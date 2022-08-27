defmodule App.PinotBrokerAdapter do
  alias Finch.Response

  require Logger

  @base_url "http://localhost:8099"

  def query(sql) do
    sql = sql |> String.trim() |> String.replace("\n", " ")
    body = Jason.encode!(%{sql: sql})

    :post
    |> Finch.build("#{@base_url}/query/sql", [], body)
    |> Finch.request(AppFinch)
    |> handle_response(sql)
  end

  defp handle_response({:ok, %Response{status: 200, body: body}}, sql) do
    handle_body(Jason.decode!(body), sql)
  end

  defp handle_response({kind, response}, sql) do
    Logger.error(
      "Query error. kind=#{inspect(kind)}, response=#{inspect(response)}, sql=#{inspect(sql)}"
    )

    {kind, {sql, response}}
  end

  defp handle_body(%{"resultTable" => %{"rows" => [[value]]}} = data, sql) do
    if(value == 0, do: Logger.warning("Query return zero. sql=#{sql}"))

    {:ok, {sql, data}}
  end

  defp handle_body(data, sql) do
    Logger.error("Query error. data=#{inspect(data)}, sql=#{inspect(sql)}")

    {:error, {sql, data}}
  end
end
