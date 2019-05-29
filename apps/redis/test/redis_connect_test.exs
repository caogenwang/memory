defmodule Redis.Repo.Query do
  require Logger
  alias Redis.Repo.Search.Service, as: Service
  use Redis.DataCase
  use ExUnit.Case, async: true

  test "connect" do
    password = "123456"
    redis_url = "redis://:#{password}@localhost:7002/1"
    {:ok, conn} = Redix.start_link(redis_url, name: :redix)
    Logger.warn "conn:#{inspect conn}"
    {:ok, conn} = Redix.start_link(redis_url, name: :redix)
    # w = Redix.command(conn, ["SET", "foo",1])
    # w = Redix.command(conn, ["GET", "foo"])
    Logger.warn "conn:#{inspect conn}"
  end

end
