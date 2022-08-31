defmodule App.Application do
  use Application

  alias App.ConsultServer
  alias App.ProducerServer
  alias App.FixedProducerServer

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
      ConsultServer.build_children() ++
        ProducerServer.build_children() ++ FixedProducerServer.build_children()
    else
      []
    end
  end
end
