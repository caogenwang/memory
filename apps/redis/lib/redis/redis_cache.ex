defmodule Redis.Cache.Service do
  require Logger
  import Redix.URI
  @redis_url "redis://localhost:7001/"


  def redis_select(urls_list) do
    urls_list=["redis://localhost:7001/","redis://localhost:7002/","redis://localhost:7003/"]
    Enum.reduce(urls_list,%{},fn url , acc->
      info = redis_replication(url)
      role = info["role"]

      case role do
        "master" -> Map.put(acc,"master",url)
        "slave"  -> Map.put(acc,"slave",url)
                    if info["master_link_status"] == "up" do
                      Map.put(acc,"slave",url)
                    end
          _      ->{:error}
      end

    end)
  end
  def redis_replication(redis_url) do
    redis_name = String.to_atom(redis_url)
    {:ok, conn} = Redix.start_link(redis_url, name: redis_name)
    {:ok, info} = Redix.command(conn,["INFO","Replication"])
    info
    |> String.split("\r\n")
    |> Enum.filter(fn string ->
          if !(string === "") do
            !String.contains?(string,"#")
          else
            false
          end
        end)
   |>  Enum.reduce([],fn string ,acc->
            list = String.split(string,":")
            acc++list
          end)
    |> Enum.chunk_every(2)
    |> Enum.reduce(%{},fn list,acc->
      Map.put_new(acc,List.first(list),List.last(list))
    end)
  end

  def hash_id(id) do
    hash_num = String.to_integer(String.at(id, -1))
    Integer.to_string(div(hash_num,4))
  end
  def redis_url(id) do
    hash_key =  hash_id(id)
    "redis://localhost:700#{hash_key}/"
  end

  def expire_time(conn,key,second) do
    cmd = ["EXPIRE","#{key}",second]
    what = Redix.command(conn, cmd)
  end

  def start_link(redis_url) do
    {:ok, conn} = Redix.start_link(redis_url, name: :redix)
    conn
  end

  def start_link(redis_url,port,password) do
    Redix.start_link(host: redis_url, port: port, password: password)
  end

  def file_set(param,second) do
    key = param["id"]
    value = Poison.encode!(param)
    url = redis_select([])
    Logger.warn "url:#{inspect url["master"]}"
    conn = start_link(url["master"])
    Logger.warn "key:#{inspect key}"
    Logger.warn "value:#{inspect value}"
    what = Redix.command(conn, ["SET", "#{key}","#{value}"])
    if second != 0 do
      expire_time(conn,"#{key}",60*60*12)
    end

  end

  def file_get(id) do
    url = redis_select([])
    Logger.warn "url:#{inspect url["slave"]}"
    conn = start_link(url["slave"])
    {_,meta} = Redix.command(conn, ["GET", "#{id}"])
    case meta do
      nil -> nil
      _   -> Poison.decode!(meta)
    end
  end

  def meta(id,key) do
    meta = file_get(id)
    meta["#{key}"]
  end

  def file_hset(param,second) do
    hash_key = param["id"]
    keys = Map.keys(param)
    value =
    Enum.reduce(keys,[],fn key,acc ->
        acc++[key,Map.get(param,key)]
    end)
    cmd = ["HMSET","#{hash_key}"] ++ value
    url = redis_select([])
    Logger.warn "url:#{inspect url["master"]}"
    conn = start_link(url["master"])
    what = Redix.command(conn, cmd)

    if second != 0 do
      expire_time(conn,"#{hash_key}",60*60*12)
    end

  end

  def file_hget(id,keys) when is_list(keys) do
    cmd = ["HMGET","#{id}"] ++ keys
    url = redis_select([])
    Logger.warn "url:#{inspect url["slave"]}"
    conn = start_link(url["slave"])
    {_,result} = Redix.command(conn, cmd)
    case result do
      nil -> nil
      _   ->assemble(result,keys)
    end
  end

  def assemble(result,keys) do
    count = Enum.count(keys)
    nums = Enum.concat([0..count-1])
    Enum.reduce(nums,%{},fn num,acc ->
      Map.put_new(acc,Enum.at(keys,num),Enum.at(result,num))
    end)
  end

  def file_hget_all(id) do
    cmd = ["HGETALL"] ++ [id]
    url = redis_select([])
    Logger.warn "url:#{inspect url["slave"]}"
    conn = start_link(url["slave"])
    {_,result} = Redix.command(conn, cmd)
    case result do
      nil -> nil
      _   ->assemble(result)
    end
  end

  def assemble(lists) do
    lists = Enum.chunk_every(lists,2)
    Enum.reduce(lists,%{},fn list,acc->
        Map.put_new(acc,List.first(list),List.last(list))
    end)
  end

  def file_del(id) do
    key = id
    cmd = ["DEL","#{key}"]
    url = redis_select([])
    Logger.warn "url:#{inspect url["master"]}"
    conn = start_link(url["master"])
    what = Redix.command(conn, cmd)
  end

  def file_multi_set(param_list,second) when is_list(param_list) do
    Enum.map(param_list,fn param ->
      file_hset(param,second)
    end)
  end



  def file_pipeline_set(map_list,second) when is_list(map_list) do

    cmd_all =
    Enum.reduce(map_list,[],fn map ,acc->
      hash_key = map["id"]
      keys = Map.keys(map)
      value =
      Enum.reduce(keys,[],fn key,acc ->
          acc++[key,Map.get(map,key)]
          end)
      cmd = ["HMSET","#{hash_key}"] ++ value
      acc++[cmd]++[["EXPIRE","#{hash_key}",second]]
    end)

    Logger.warn "cmd_all:#{inspect cmd_all}"

    url = redis_select([])
    Logger.warn "url:#{inspect url["master"]}"
    conn = start_link(url["master"])
    what = Redix.pipeline!(conn, cmd_all)
  end

  def file_pipeline_set(map_list,second) do
    Logger.warn "param has someting wrong!"
  end

end
