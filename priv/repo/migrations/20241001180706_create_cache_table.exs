defmodule AlphavantageElixirClient.Repo.Migrations.CreateCacheTable do
  use Ecto.Migration

  def change do
    create table(:cache) do
      add :symbol, :string
      add :response, :map

      timestamps()
    end

    create unique_index(:cache, [:symbol])
  end
end
