defmodule AlphavantageElixirClientTest do
  use ExUnit.Case

  alias AlphavantageElixirClient

  @api_key "demo"

  test "fetch_etf_profile/2 returns a response" do
    symbol = "QQQ"
    response = AlphavantageElixirClient.fetch_etf_profile(symbol, @api_key)

    IO.inspect(response.body)

    # General Checks
    assert response.status == 200
    assert is_map(response.body)

    # Check respnse body structure
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
      assert Map.has_key?(response.body, key)
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
      assert Map.has_key?(response.body["asset_allocation"], key)
    end
  end
end
