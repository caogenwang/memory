defmodule Redis.Repo.Query do
  require Logger
  alias Redis.Repo.Search.Service, as: Service
  use Redis.DataCase
  use ExUnit.Case, async: true

  # test "set" do
  #   values = %{
  #     "key" => "docin",
  #     "location" => "beijing",
  #     "type" => "internet",
  #     "employee" => 50,
  #     "expire" => 10
  #   }
  #   what = Redis.Cache.Service.key_value_set(values)
  #   Logger.warn "what:#{inspect what}"
  # end

  # test "get" do
  #   values = %{
  #     "key" => "docin"
  #   }
  #   what = Redis.Cache.Service.key_value_get(values)
  #   Logger.warn "what:#{inspect what}"
  # end

  # test "update" do
  #   values = %{
  #     "key" => "docin",
  #     "employee" => 40,
  #     "expire" => 10
  #   }
  #   what = Redis.Cache.Service.key_value_update(values)
  #   Logger.warn "what:#{inspect what}"
  # end

  # test "get" do
  #   values = %{
  #     "key" => "docin"
  #   }
  #   what = Redis.Cache.Service.key_value_get(values)
  #   Logger.warn "what:#{inspect what}"
  # end

  # test "delete" do
  #   values = %{
  #     "key" => "docin"
  #   }
  #   what = Redis.Cache.Service.key_value_del(values)
  #   Logger.warn "what:#{inspect what}"
  # end

  test "post" do
    addKeyURL = "http://localhost:4000/redis/key_value_set"

      meta_map = %{
                  "key" => "docin",
                  "converted_by" => "convert_worker",
                  "file_size" => "366823", "height" => "842.25",
                  "host_name" => "dfs_store_001", "id" => "64135088",
                  "page_count" => "6", "version" => "1.2", "width" => "595.5",
                  "zip_size" => "680656",
                  "expire" => 0}

       what = HTTPoison.post(addKeyURL, Poison.encode!(meta_map), [{"Content-Type", "application/json"}])
       # addFileURL = "http://localhost:4000/info_set?id=64135088&converted_by=convert_worker&host_name=dfs_store_001"
       # what = HTTPoison.get(addFileURL)
      Logger.warn "what:#{inspect what}"
  end
end
