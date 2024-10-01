import Config

config :alphavantage_elixir_client, AlphavantageElixirClient.Repo,
  database:
    Application.get_env(:alphavantage_elixir_client, :db_name, "alphavantage_elixir_client_dev"),
  username: Application.get_env(:alphavantage_elixir_client, :db_username, "postgres"),
  password: Application.get_env(:alphavantage_elixir_client, :db_password, "postgres"),
  hostname: Application.get_env(:alphavantage_elixir_client, :db_hostname, "localhost"),
  port: Application.get_env(:alphavantage_elixir_client, :db_port, "5432")

config :alphavantage_elixir_client, ecto_repos: [AlphavantageElixirClient.Repo]
