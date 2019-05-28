defmodule RedisWeb.RedisController do
  use RedisWeb, :controller
  require  Logger
  def file_record(conn, %{"id" => id} = meta) do
    w = Redis.Cache.Service.file_hset(meta)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"
  end
end
