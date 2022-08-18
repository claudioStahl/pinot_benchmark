defmodule App.ProducerServer do
  use GenServer

  require Logger

  alias App.Producer

  def child_spec(options) do
    %{
      id: {__MODULE__, options[:number]},
      start: {__MODULE__, :start_link, [options]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(options) do
    name = String.to_atom("#{__MODULE__}:#{options[:number]}")

    Logger.info("Start #{name}")

    GenServer.start_link(__MODULE__, options, name: name)
  end

  def init(options) do
    send(self(), :produce)

    {:ok, options}
  end

  def handle_info(:produce, state) do
    Producer.produce()

    send(self(), :produce)

    {:noreply, state}
  end

  def handle_info(_type, state) do
    {:noreply, state}
  end
end
