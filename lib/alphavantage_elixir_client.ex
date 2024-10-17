defmodule AlphavantageElixirClient do
  alias AlphavantageElixirClient.{Repo, Cache}

  def fetch_etf_profile(symbol, api_key) do
    IO.puts("AlphavantageElixirClient: Etf profile for symbol #{symbol} requested.")

    case Repo.get_by(Cache, symbol: symbol) do
      nil ->
        IO.puts(
          "AlphavantageElixirClient: No etf profile cached for symbol #{symbol}. Hitting alphavantage api."
        )

        response = Worker.start_request("ETF_PROFILE", symbol, api_key)
        {:ok, cached_response} = cache_response(symbol, response.body)
        Map.put(cached_response.response, "cache_updated_at", cached_response.updated_at)

      # cached_response.response

      cached_response ->
        IO.puts("AlphavantageElixirClient: Etf profile for symbol #{symbol} found in cache.")
        Map.put(cached_response.response, "cache_updated_at", cached_response.updated_at)
        # cached_response.response
    end
  end

  defp cache_response(symbol, response) do
    IO.puts("AlphavantageElixirClient: Caching response for symbol #{symbol}.")

    %Cache{}
    |> Cache.changeset(%{symbol: symbol, response: response})
    |> Repo.insert()
  end
end
