defmodule App.Application do
  use Application

  alias App.ProducerServer

  @parallel 20

  @impl true
  def start(_type, _args) do
    children = basic_children() ++ prod_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp basic_children do
    [
      App.Telemetry,
      {Finch, name: AppFinch}
    ]
  end

  defp prod_children do
    if Mix.env() == :prod do
      producer_children()
    else
      []
    end
  end

  defp producer_children do
    Enum.map(1..@parallel, &{ProducerServer, number: &1})
  end
end
