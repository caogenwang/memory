defmodule Redis.Repo.Search.Service do#操作获取数据的数据库Repo
    use Ecto.Schema
    import Ecto.Query
    import Ecto.Changeset
    require Logger
    alias Redis.Repo

    schema "default" do
      field(:meta, :string)
    end

    def queryTableFromOldDatabase(table) do
      %Ecto.Query{from: {"#{table}", __MODULE__}, prefix: (nil)}
    end

    def query(table) do
      from(
        u in queryTableFromOldDatabase(table),
        where: u.id > ^0,
        # select: %{id: u.id,meta: u.meta},
        limit: ^1
      )
      |> Repo.all
    end
end
