defmodule Redis.Start do
  use GenServer
  require Logger

  def start_link(args) do
    pid = GenServer.start_link(__MODULE__, %{module: __MODULE__,url: args}, name: __MODULE__)
  end

  def init(arg) do
    Logger.warn "arg:#{inspect arg}"
    redis_urls = Map.get(arg,:url)
    Enum.map(redis_urls,fn url ->
      redis_name = String.to_atom(url)
      {:ok,conn} = Redix.start_link(url, name: redis_name)
      w = Redix.command(conn, ["PING"])
      Logger.warn "w:#{inspect conn},#{inspect w}"
    end)
    {:ok, arg}
  end
end
