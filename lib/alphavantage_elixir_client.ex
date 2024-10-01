defmodule AlphavantageElixirClient do
  alias AlphavantageElixirClient.{Repo, Cache}

  def fetch_etf_profile(symbol, api_key) do
    case Repo.get_by(Cache, symbol: symbol) do
      nil ->
        response = Worker.start_request("ETF_PROFILE", symbol, api_key)
        cache_response(symbol, response.body)
        response.body

      cached_response ->
        cached_response.response
    end
  end

  defp cache_response(symbol, response) do
    %Cache{}
    |> Cache.changeset(%{symbol: symbol, response: response})
    |> Repo.insert()
  end
end
