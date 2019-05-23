defmodule Redis.Repo.Migrations.AddFileMetas do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:file_meta) do
      add :meta, :string
      timestamps
    end
    create unique_index(:file_meta, [:id], name: :id_index)
  end
end
