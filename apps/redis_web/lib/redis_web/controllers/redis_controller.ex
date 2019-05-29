defmodule RedisWeb.RedisController do
  use RedisWeb, :controller
  require  Logger
  def info_set(conn, %{"id" => id} = meta) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    w = Redis.Cache.Service.file_hset(meta)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(%{}))
  end

  def info_get(conn, %{"id" => id} = meta) do

    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    w = Redis.Cache.Service.file_hget_all(meta["id"])
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(w))
  end

  def info_del(conn, %{"id" => id} = meta) do

    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    {_,w} = Redis.Cache.Service.file_del(meta["id"])
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(w))
  end


  def key_value_set(conn, %{"key"=>key,"expire"=>time}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    w = Redis.Cache.Service.key_value_set(values)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(%{}))
  end

  def key_value_get(conn, %{"key"=>key}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    w = Redis.Cache.Service.key_value_get(values)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(w))
  end

  def key_value_del(conn, %{"key"=>key}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    w = Redis.Cache.Service.key_value_del(values)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(%{}))
  end

  def key_value_update(conn, %{"key"=>key}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    w = Redis.Cache.Service.key_value_update(values)
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect w}"

    conn |> json(ok(%{}))
  end

end
