import Config

database = "alphavantage_elixir_client_test"

config :alphavantage_elixir_client, AlphavantageElixirClient.Repo,
  database: database,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

IO.puts("alphavantage_elixir_client is using database #{database}")
