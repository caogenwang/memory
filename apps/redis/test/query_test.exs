

defmodule Redis.Repo.Query do
  require Logger
  alias Redis.Repo.Search.Service, as: Service
  use Redis.DataCase
  use ExUnit.Case, async: true

  test "query" do
    table = "file_metas"
    w = Service.query(table)
    Logger.warn "w:#{inspect w}"
  end


end

