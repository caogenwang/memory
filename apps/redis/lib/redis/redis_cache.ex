defmodule Redis.Cache.Service do
  require Logger
  import Redix.URI
  @password  "123456"
  @redis_urls [
    "redis://:#{@password}@localhost:7001/",
    "redis://:#{@password}@localhost:7002/",
    "redis://:#{@password}@localhost:7003/"
  ]
  def redis_select() do
    Enum.reduce(@redis_urls,%{},fn url , acc->

      redis_name = String.to_atom(url)
      conn = Process.whereis(redis_name)

      info = redis_replication(conn)
      role = info["role"]

      case role do
        "master" -> Map.put(acc,"master",conn)
        "slave"  -> Map.put(acc,"slave",conn)
                    if info["master_link_status"] == "up" do
                      Map.put(acc,"slave",conn)
                    end
          _      ->{:error}
      end

    end)
  end
  def redis_replication(conn) do
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

  def start_link(redis_url,port,password) do
    Redix.start_link(host: redis_url, port: port, password: password)
  end

  def file_set(param,second \\ 0) do
    key = param["id"]
    value = Poison.encode!(param)
    conns = redis_select()
    Logger.warn "conn:#{inspect conns["master"]}"
    Logger.warn "key:#{inspect key}"
    Logger.warn "value:#{inspect value}"
    what = Redix.command(conns["master"], ["SET", "#{key}","#{value}"])
    if second != 0 do
      expire_time(conns["master"],"#{key}",second)
    end

  end

  def file_get(id) do
    conns = redis_select()
    Logger.warn "url:#{inspect conns["slave"]}"
    {_,meta} = Redix.command(conns["slave"], ["GET", "#{id}"])
    case meta do
      nil -> nil
      _   -> Poison.decode!(meta)
    end
  end

  def meta(id,key) do
    meta = file_get(id)
    meta["#{key}"]
  end

  def file_hset(param,second \\ 0) do
    hash_key = param["id"]
    keys = Map.keys(param)
    value =
    Enum.reduce(keys,[],fn key,acc ->
        acc++[key,Map.get(param,key)]
    end)
    cmd = ["HMSET","#{hash_key}"] ++ value
    conns = redis_select()
    Logger.warn "url:#{inspect conns["master"]}"
    what = Redix.command(conns["master"], cmd)

    if second != 0 do
      expire_time(conns["master"],"#{hash_key}",second)
    end

  end

  def file_hget(id,keys) when is_list(keys) do
    cmd = ["HMGET","#{id}"] ++ keys
    conns = redis_select()
    Logger.warn "url:#{inspect conns["slave"]}"
    {_,result} = Redix.command(conns["slave"], cmd)
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
    conns = redis_select()
    Logger.warn "url:#{inspect conns["slave"]}"
    {_,result} = Redix.command(conns["slave"], cmd)
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
    conns = redis_select()
    Logger.warn "url:#{inspect conns["master"]}"
    what = Redix.command(conns["master"], cmd)
  end

  def file_multi_set(param_list,second \\ 0) when is_list(param_list) do
    Enum.map(param_list,fn param ->
      file_hset(param,second)
    end)
  end

  @spec file_pipeline_set(any, any) ::
          :ok
          | [nil | binary | [nil | binary | [any] | integer | map] | integer | Redix.Error.t()]
          | {:error, any}
  def file_pipeline_set(map_list,second \\ 0) do

    cmd_all =
    Enum.reduce(map_list,[],fn map ,acc->
      hash_key = map["id"]
      keys = Map.keys(map)
      value =
      Enum.reduce(keys,[],fn key,acc ->
          acc++[key,Map.get(map,key)]
          end)
      cmd = ["HMSET","#{hash_key}"] ++ value
      if second != 0 do
        acc++[cmd]++[["EXPIRE","#{hash_key}",second]]
      else
        acc++[cmd]
      end

    end)

    Logger.warn "cmd_all:#{inspect cmd_all}"

    conns = redis_select()
    Logger.warn "url:#{inspect conns["master"]}"
    what = Redix.pipeline!(conns["master"], cmd_all)
  end

def key_value_set(%{"key"=>key,"expire"=>time}=values) do
    key = values["key"]
    expire_time = values["expire"]
    what = key_value_hset(key,values,expire_time)
end

def key_value_get(%{"key"=>key}=values) do
  key = values["key"]
  what = file_hget_all(key)
end

def key_value_del(%{"key"=>key}=values) do
  key = values["key"]
  what = file_del(key)
end

def key_value_update(%{"key"=>key}=values) do
    key=values["key"]
    keys_value =
    values
    |> Map.keys()
    |> Enum.filter(fn k ->
         k != "key"
     end)
     Logger.warn "keys_value:#{inspect keys_value}"
      conns = redis_select()
      Logger.warn "url:#{inspect conns["master"]}"
      Enum.map(keys_value,fn key_value ->
        cmd=["HSET",key,key_value,Map.get(values,key_value)]
        what = Redix.command(conns["master"], cmd)
        Logger.warn "what:#{inspect what}"
    end)
end

@spec key_value_hset(any, map, any) ::
        nil
        | {:error,
           atom
           | %{
               :__exception__ => any,
               :__struct__ => Redix.ConnectionError | Redix.Error,
               optional(:message) => binary,
               optional(:reason) => atom
             }}
        | {:ok, nil | binary | [nil | binary | [any] | integer | map] | integer | Redix.Error.t()}
def key_value_hset(k,values,second \\ 0) do
  keys = Map.keys(values)
  value =
  Enum.reduce(keys,[],fn key,acc ->
      acc++[key,Map.get(values,key)]
      end)
  cmd = ["HMSET","#{k}"] ++ value
  conns = redis_select()
  Logger.warn "url:#{inspect conns["master"]}"
  what = Redix.command(conns["master"], cmd)

  if second != 0 do
    expire_time(conns["master"],"#{k}",second)
  end

end

end
