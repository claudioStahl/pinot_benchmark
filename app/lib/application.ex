defmodule App.Application do
  use Application

  alias App.ProducerServer

  @parallel 20

  @impl true
  def start(_type, _args) do
    children = producer_servers()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def producer_servers do
    Enum.map(1..@parallel, &{ProducerServer, number: &1})
  end
end
