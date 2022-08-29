defmodule App.Application do
  use Application

  alias App.ConsultServer
  alias App.ProducerServer

  @parallel_consult 10
  @parallel_producer 10

  @impl true
  def start(_type, _args) do
    children = basic_children() ++ telemetry_children() ++ prod_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp basic_children do
    [{Finch, name: AppFinch}]
  end

  defp telemetry_children do
    if Mix.env() == :prod do
      [App.Telemetry]
    else
      []
    end
  end

  defp prod_children do
    if Mix.env() == :prod do
      consult_children() ++ producer_children()
    else
      []
    end
  end

  defp consult_children do
    if @parallel_consult > 0 do
      Enum.map(1..@parallel_consult, &{ConsultServer, number: &1})
    else
      []
    end
  end

  defp producer_children do
    if @parallel_producer > 0 do
      Enum.map(1..@parallel_producer, &{ProducerServer, number: &1})
    else
      []
    end
  end
end
