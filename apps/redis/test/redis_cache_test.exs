
defmodule Redis.Repo.Query do
  require Logger
  alias Redis.Repo.Search.Service, as: Service
  use Redis.DataCase
  use ExUnit.Case, async: true

  # test "set" do
  #   table = "file_metas"
  #   [w] = Service.query(table)
  #   meta = Poison.decode!(Map.get(w,:meta))
  #   second = 6000
  #   w = Redis.Cache.Service.file_set(meta,second)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "delete" do
  #   id = "64135088"
  #   w = Redis.Cache.Service.file_del(id)
  #   Logger.warn "w:#{inspect w}"
  # end
#
  # test "get" do
  #   id = "64135088"
  #   w = Redis.Cache.Service.file_get(id)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "hset" do
  #   table = "file_metas"
  #   [w] = Service.query(table)
  #   meta = Poison.decode!(Map.get(w,:meta))
  #   second = 600
  #   w = Redis.Cache.Service.file_hset(meta,second)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "hget" do
  #   id = "64135088"
  #   w = Redis.Cache.Service.file_hget_all(id)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "hget" do
  #   id = "64135088"
  #   keys = ["converted_by","id"]
  #   w = Redis.Cache.Service.file_hget(id,keys)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "hash" do
  #   id = "64135088"
  #   w = Redis.Cache.Service.redis_url(id)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "pipeline" do
  #   map_list = [
  #     %{"id"=>"123456","store"=>"dfs_master"},
  #     %{"id"=>"235698","store"=> "dfs_slave"}
  #   ]
  #   w = Redis.Cache.Service.file_pipeline_set(map_list,60)
  #   Logger.warn "w:#{inspect w}"
  # end

  # test "sentinel" do

  #   redis_url = "redis://:123456@localhost:7001/1"
  #   {:ok, conn} = Redix.start_link(redis_url, name: :redis1)
  #   Logger.warn "conn:#{inspect conn}"
  #   w = Redix.command(conn,["SET","sentinel","success"])
  #   w = Redix.command(conn,["INFO","Replication"])
  #   Logger.warn "w:#{inspect w}"

  #   redis_url = "redis://:123456@localhost:7002/1"
  #   {:ok, conn} = Redix.start_link(redis_url, name: :redis2)
  #   Logger.warn "ping:#{inspect Redix.command!(conn, ["PING"])}"
  #   Logger.warn "conn:#{inspect conn}"
  #   w = Redix.command(conn,["SET","sentinel","success"])
  #   Logger.warn "w:#{inspect w}"

  #   redis_url = "redis://:123456@localhost:7003/2"
  #   {:ok, conn} = Redix.start_link(redis_url, name: :redis3)
  #   Logger.warn "ping:#{inspect Redix.command!(conn, ["PING"])}"
  #   Logger.warn "conn:#{inspect conn}"
  #   w = Redix.command(conn,["SET","sentinel","success"])
  #   Logger.warn "w:#{inspect w}"


  #   sentinels = ["redis://localhost:8001/"]
  #   {:ok, primary} = Redix.start_link(sentinel: [sentinels: sentinels, group: "mymaster"])
  #   Logger.warn "primary:#{inspect primary}"
  # end


  # test "seclect master" do
  #   redis_url = "redis://localhost:7001/"
  #   redis_name = String.to_atom(redis_url)
  #   {:ok, conn} = Redix.start_link(redis_url, name: redis_name)
  #   {:ok, info} = Redix.command(conn,["INFO","Replication"])
  #   map =
  #   info
  #   |> String.split("\r\n")
  #   |> Enum.filter(fn string ->
  #         if !(string === "") do
  #           !String.contains?(string,"#")
  #         else
  #           false
  #         end
  #       end)
  #  |>  Enum.reduce([],fn string ,acc->
  #           list = String.split(string,":")
  #           acc++list
  #         end)
  #   |> Enum.chunk_every(2)
  #   |> Enum.reduce(%{},fn list,acc->
  #     Map.put_new(acc,List.first(list),List.last(list))
  #   end)
  #   Logger.warn "map:#{inspect map}"
  # end

  # test "select" do
  #   w = Redis.Cache.Service.redis_select([])
  #   Logger.warn "w:#{inspect w}"
  # end

  test "add cache" do
      addFileURL = "http://localhost:4000/redis/info_set"

      meta_map = %{"converted_by" => "convert_worker",
                  "file_size" => "366823", "height" => "842.25",
                  "host_name" => "dfs_store_001", "id" => "64135088",
                  "page_count" => "6", "version" => "1.2", "width" => "595.5",
                  "zip_size" => "680656"}

       what = HTTPoison.post(addFileURL, Poison.encode!(meta_map), [{"Content-Type", "application/json"}])
       # addFileURL = "http://localhost:4000/info_set?id=64135088&converted_by=convert_worker&host_name=dfs_store_001"
       # what = HTTPoison.get(addFileURL)
      Logger.warn "what:#{inspect what}"
  end
end
