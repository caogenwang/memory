defmodule RedisWeb.RedisController do
  use RedisWeb, :controller
  require  Logger
  def info_set(conn, %{"id" => id} = meta) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    # # w = Redis.Cache.Service.file_hset(meta)
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{}))
  end

  def info_get(conn, %{"id" => id} = meta) do

    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    # w = Redis.Cache.Service.file_hget_all(meta["id"])
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"
    w=%{"converted_by" => "convert_worker",
    "file_size" => "366823", "height" => "842.25",
    "host_name" => "dfs_store_001", "id" => "64135088",
    "page_count" => "6", "version" => "1.2", "width" => "595.5",
    "zip_size" => "680656"}

    conn |> json(ok(w))
  end

  def info_del(conn, %{"id" => id} = meta) do

    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect meta}"

    # w = Redis.Cache.Service.file_del(meta["id"])
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{}))
  end


  def key_value_set(conn, %{"key"=>key,"expire"=>time}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    # w = Redis.Cache.Service.key_value_set(values)
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{}))
  end

  def key_value_get(conn, %{"key"=>key}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    # w = Redis.Cache.Service.key_value_get(values)
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{}))
  end

  def key_value_del(conn, %{"key"=>key}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    # w = Redis.Cache.Service.key_value_del(values)
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{}))
  end

  def key_value_update(conn, %{"key"=>key}=values) do
    Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    #{inspect values}"

    # w = Redis.Cache.Service.key_value_update(values)
    # Logger.warn "file: #{inspect Path.basename(__ENV__.file)}  line: #{__ENV__.line}
    # #{inspect w}"

    conn |> json(ok(%{}))
  end

end
