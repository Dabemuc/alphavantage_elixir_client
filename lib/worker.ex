defmodule Worker do
  @moduledoc false

  def start_request(function, symbol, api_key) do
    perform_request(function, symbol, api_key)
  end

  defp perform_request(function, symbol, api_key) do
    Req.get!(
      "https://www.alphavantage.co/query?function=#{function}&symbol=#{symbol}&apikey=#{api_key}"
    )
  end
end
