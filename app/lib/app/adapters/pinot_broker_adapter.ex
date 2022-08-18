defmodule App.PinotBrokerAdapter do
  @base_url "http://localhost:8099"

  def query(sql) do
    body = Jason.encode!(%{sql: sql})

    :post
    |> Finch.build("#{@base_url}/query/sql", [], body)
    |> Finch.request(AppFinch)
  end
end
