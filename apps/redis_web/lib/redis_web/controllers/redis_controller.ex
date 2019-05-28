defmodule RedisWeb.RedisController do
  use RedisWeb, :controller
  require  Logger
  def info_set(conn, %{"id" => id} = meta) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    # # w = Redis.Cache.Service.file_hset(meta)
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{meta: %{
      version: to_string(Application.spec(:RedisWeb,:vsn))
    }}))
  end
  @spec info_get(any, map) :: :ok | {:error, any}
  @spec info_get(Plug.Conn.t(), map) :: Plug.Conn.t()
  def info_get(conn, %{"id" => id} = meta) do

    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    # w = Redis.Cache.Service.file_hget_all(meta["id"])
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{meta: %{
      version: to_string(Application.spec(:RedisWeb,:vsn))
    }}))
  end

  def info_del(conn, %{"id" => id} = meta) do

    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    # w = Redis.Cache.Service.file_del(meta["id"])
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{meta: %{
      version: to_string(Application.spec(:RedisWeb,:vsn))
    }}))
  end


end
