defmodule Redix.URITest do
  use ExUnit.Case, async: true
  import Redix.URI
  require Logger
  test "connection" do
    {:ok, conn} = Redix.start_link("redis://localhost:7001/", name: :redix)
    Logger.warn "conn:#{inspect conn}"

    w = Redix.command(conn, ["SET", "foo",1])
    Logger.warn "w :#{inspect w }"
    w = Redix.pipeline(conn, [["INCR", "foo"], ["INCR", "foo"], ["INCRBY", "foo", "2"]])
    Logger.warn "w :#{inspect w }"
    get = Redix.command(conn, ["GET", "foo"])
    Logger.warn "get:#{inspect get}"
    # meta = "{\"zip_size\":680656,\"width\":595.5,\"version\":1.2,\"page_count\":6,\"id\":\"64135088\",\"host_name\":\"dfs_store_001\",\"height\":842.25,\"file_size\":366823,\"converted_by\":\"convert_worker\"}"
    # Redix.command!(conn, ["SET", "key","#{meta}"])

  end
  # test "pipeline" do
  #   {:ok, conn} = Redix.start_link("redis://localhost:16379/", name: :redix)
  #   w = Redix.command(conn, ["SET", "foo",1])
  #   Logger.warn "w:#{inspect w}"
  #   # w = Redix.pipeline(conn, [["INCR", "foo"], ["INCR", "foo"], ["INCRBY", "foo", "2"]])

  # end
end
