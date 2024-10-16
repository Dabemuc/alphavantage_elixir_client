import Config

IO.puts("Running alphavantage_elixir_client in #{config_env()} env")

if config_env() != :test do
  database =
    Application.get_env(:alphavantage_elixir_client, :db_name, "alphavantage_elixir_client")

  config :alphavantage_elixir_client, AlphavantageElixirClient.Repo,
    database: database,
    username: Application.get_env(:alphavantage_elixir_client, :db_username, "postgres"),
    password: Application.get_env(:alphavantage_elixir_client, :db_password, "postgres"),
    hostname: Application.get_env(:alphavantage_elixir_client, :db_hostname, "localhost"),
    port: Application.get_env(:alphavantage_elixir_client, :db_port, "5432")

  config :alphavantage_elixir_client, ecto_repos: [AlphavantageElixirClient.Repo]

  IO.puts("alphavantage_elixir_client is using database #{database}")
else
  import_config "test.exs"
end
