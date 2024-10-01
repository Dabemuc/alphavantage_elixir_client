defmodule AlphavantageElixirClient.Repo do
  use Ecto.Repo,
    otp_app: :alphavantage_elixir_client,
    adapter: Ecto.Adapters.Postgres
end
