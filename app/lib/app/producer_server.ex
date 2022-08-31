defmodule App.ProducerServer do
  use GenServer

  require Logger

  alias App.Producer

  def build_children do
    enable_producer_server = Application.fetch_env!(:app, :enable_producer_server)
    parallel_producer = Application.fetch_env!(:app, :parallel_producer)

    if enable_producer_server && parallel_producer > 0 do
      Enum.map(1..parallel_producer, &{__MODULE__, number: &1})
    else
      []
    end
  end

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
    case Producer.produce() do
      :ok ->
        Process.send_after(self(), :produce, 1)

      {:error, _} ->
        Process.send_after(self(), :produce, 5_000)
    end

    {:noreply, state}
  end

  def handle_info(_type, state) do
    {:noreply, state}
  end
end
