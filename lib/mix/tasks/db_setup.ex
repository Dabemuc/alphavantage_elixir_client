defmodule Mix.Tasks.DbSetup do
  use Mix.Task

  @shortdoc "Sets up the database structure for AlphavantageElixirClient"

  def run(_) do
    Mix.Task.run("ecto.create", ["--quiet"])
    Mix.Task.run("ecto.migrate", ["--quiet"])
    IO.puts("AlphavantageElixirClient Database setup complete.")
  end
end
