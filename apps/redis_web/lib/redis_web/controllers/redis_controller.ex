defmodule RedisWeb.RedisController do
  use RedisWeb, :controller
  require  Logger
  def info_set(conn, %{"id" => id} = meta) do
    w = Redis.Cache.Service.file_hset(meta)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"
  end
  @spec info_get(any, map) :: :ok | {:error, any}
  def info_get(conn, %{"id" => id} = meta) do
    w = Redis.Cache.Service.file_hget_all(meta["id"])
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"
  end
end
