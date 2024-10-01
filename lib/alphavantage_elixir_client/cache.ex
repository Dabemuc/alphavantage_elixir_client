defmodule AlphavantageElixirClient.Cache do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cache" do
    field(:symbol, :string)
    field(:response, :map)

    timestamps()
  end

  def changeset(cache, attrs) do
    cache
    |> cast(attrs, [:symbol, :response])
    |> validate_required([:symbol, :response])
    |> unique_constraint(:symbol)
  end
end
