# Alphavantage Elixir Client

This is a plugin for fetching data from the AlphaVantage API and caching the fetched data in a PostgreSQL database using Ecto.

## Installation

Add `alphavantage_elixir_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:alphavantage_elixir_client, "~> 0.1.0"}
  ]
end
```

## Configuration

To configure the database settings, add the following to your `config/config.exs`:

```elixir
config :alphavantage_elixir_client, AlphavantageElixirClient.Repo,
  database: "your_database_name",
  username: "your_database_username",
  password: "your_database_password",
  hostname: "your_database_hostname",
  port: "5432"

config :alphavantage_elixir_client, ecto_repos: [AlphavantageElixirClient.Repo]
```

## Database Setup

To set up the database structure for the plugin, run the following Mix task:

```sh
mix db.setup
```

This task will create and migrate the database.

## Usage

TODO: Update

Here's an example of how to use the plugin to fetch and cache data from the AlphaVantage API:

```elixir
defmodule MyApp.AlphavantageClient do
  alias AlphavantageElixirClient

  def fetch_etf_profile(symbol, api_key) do
    AlphavantageElixirClient.fetch_etf_profile(symbol, api_key)
  end
end
```
