defmodule DfsMaster.Repo.Search.Service do#操作获取数据的数据库Repo
    use Ecto.Schema
    import Ecto.Query
    import Ecto.Changeset
    use Timex
    require Logger
    alias DfsMaster.Repo

    schema "default" do
      field(:meta, :string)
    end

    def queryTableFromOldDatabase(table) do
      %Ecto.Query{from: {"#{table}", __MODULE__}, prefix: (nil)}
    end

    def query(table,limit,last_id) do
      from(
        u in queryTableFromOldDatabase(table),
        where: u.id > ^last_id,
        select: %{id: u.id,meta: u.meta},
        limit: ^limit
      )
      |> Repo.all
    end
end
