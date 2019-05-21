defmodule Redix.URITest do
  use ExUnit.Case, async: true
  import Redix.URI
  require Logger
  test "connection" do
    {:ok, conn} = Redix.start_link("redis://localhost:16379/", name: :redix)
    Logger.warn "conn:#{inspect conn}"
    get = Redix.command(conn, ["GET", "key"])
    Logger.warn "get:#{inspect get}"
    # meta = "{\"zip_size\":680656,\"width\":595.5,\"version\":1.2,\"page_count\":6,\"id\":\"64135088\",\"host_name\":\"dfs_store_001\",\"height\":842.25,\"file_size\":366823,\"converted_by\":\"convert_worker\"}"
    # Redix.command!(conn, ["SET", "key","#{meta}"])

  end
end
