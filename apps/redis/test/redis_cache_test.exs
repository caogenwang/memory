
defmodule Redis.Repo.Query do
  require Logger
  alias Redis.Repo.Search.Service, as: Service
  use Redis.DataCase
  use ExUnit.Case, async: true

  # test "set" do
  #   table = "file_metas"
  #   [w] = Service.query(table)
  #   meta = Poison.decode!(Map.get(w,:meta))
  #   second = 600
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

  #   redis_url = "redis://localhost:7001/"
  #   {:ok, conn} = Redix.start_link(redis_url, name: :redis1)
  #   Logger.warn "conn:#{inspect conn}"
  #   w = Redix.command(conn,["SET","sentinel","success"])
  #   w = Redix.command(conn,["INFO","Replication"])
  #   Logger.warn "w:#{inspect w}"

  #   redis_url = "redis://localhost:7002/"
  #   {:ok, conn} = Redix.start_link(redis_url, name: :redis2)
  #   Logger.warn "ping:#{inspect Redix.command!(conn, ["PING"])}"
  #   Logger.warn "conn:#{inspect conn}"
  #   w = Redix.command(conn,["SET","sentinel","success"])
  #   Logger.warn "w:#{inspect w}"

  #   redis_url = "redis://localhost:7003/"
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
end
