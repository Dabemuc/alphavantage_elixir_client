defmodule AlphavantageElixirClientTest do
  use ExUnit.Case

  alias AlphavantageElixirClient.{Repo, Cache}
  alias AlphavantageElixirClient

  @api_key "demo"

  setup_all do
    # Ensure the environment is set to test
    Mix.env(:test)

    # Create the database
    Mix.Task.run("ecto.create", [
      "--quiet",
      "-r",
      "AlphavantageElixirClient.Repo"
    ])

    # Run migrations using Mix.shell().cmd/1
    Mix.shell().cmd("MIX_ENV=test mix ecto.migrate -r AlphavantageElixirClient.Repo")

    on_exit(fn ->
      nil
      # Drop the database
      # Mix.Task.run("ecto.drop", [
      # "--quiet",
      # "-r",
      # "AlphavantageElixirClient.Repo"
      # ])
    end)

    :ok
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    :ok = Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
    :ok
  end

  test "fetch_etf_profile/2 returns a response and caches it" do
    symbol = "QQQ"

    # First call to fetch_etf_profile, should hit the API
    response = AlphavantageElixirClient.fetch_etf_profile(symbol, @api_key)

    IO.inspect(response)

    # General Checks
    assert is_map(response)

    # Check response body structure
    expected_keys = [
      "net_assets",
      "net_expense_ratio",
      "portfolio_turnover",
      "dividend_yield",
      "inception_date",
      "leveraged",
      "asset_allocation",
      "sectors",
      "holdings"
    ]

    for key <- expected_keys do
      assert Map.has_key?(response, key)
    end

    # Additional check for nested keys in asset_allocation
    asset_allocation_keys = [
      "domestic_equities",
      "foreign_equities",
      "bond",
      "cash",
      "other"
    ]

    for key <- asset_allocation_keys do
      assert Map.has_key?(response["asset_allocation"], key)
    end

    # Check if the response is cached
    cached_response = Repo.get_by(Cache, symbol: symbol)
    assert cached_response.response == response

    # Second call to fetch_etf_profile, should use the cache
    cached_response = AlphavantageElixirClient.fetch_etf_profile(symbol, @api_key)
    assert cached_response == response
  end
end
