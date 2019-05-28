defmodule Redis.Repo.Query do
  require Logger
  alias Redis.Repo.Search.Service, as: Service
  use Redis.DataCase
  use ExUnit.Case, async: true

  test "set" do
    values = %{
      "key" => "docin",
      "location" => "beijing",
      "type" => "internet",
      "employee" => 50,
      "expire" => 10
    }
    what = Redis.Cache.Service.key_value_set(values)
    Logger.warn "what:#{inspect what}"
  end

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
end
