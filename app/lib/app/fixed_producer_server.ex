defmodule App.FixedProducerServer do
  use GenServer

  require Logger

  alias App.Producer

  @topic Application.fetch_env!(:app, :topic)
  @limit 500_000_000
  @start_date ~U[2022-01-01 00:00:00.000000Z]
  @interval 1

  def build_children do
    enable_fixed_producer_server = Application.fetch_env!(:app, :enable_fixed_producer_server)
    topic = Application.fetch_env!(:app, :topic)
    {:ok, count} = :brod.get_partitions_count(:default, topic)
    total = trunc(@limit / count)

    if enable_fixed_producer_server do
      Enum.map(1..count, &{__MODULE__, number: &1, total: total})
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
    options = Keyword.put(options, :name, name)

    Logger.info("Start #{name}")

    GenServer.start_link(__MODULE__, options, name: name)
  end

  def init(options) do
    {:ok, offset} = App.KafkaProducerAdapter.resolve_offset("transcripts", 8)
    send(self(), {:produce, offset})

    {:ok,
     %{
       name: Keyword.fetch!(options, :name),
       number: Keyword.fetch!(options, :number),
       total: Keyword.fetch!(options, :total)
     }}
  end

  def handle_info({:produce, offset}, %{name: name, total: total} = state) when offset == total do
    Logger.info("Finish #{name}")

    {:noreply, state}
  end

  def handle_info({:produce, offset}, state) do
    date = DateTime.add(@start_date, offset * @interval, :second)
    Logger.info("Offset #{offset}")

    case Producer.produce(date) do
      :ok ->
        Process.send_after(self(), {:produce, offset + 1}, 1)

      {:error, _} ->
        Process.send_after(self(), {:produce, offset}, 5_000)
    end

    {:noreply, state}
  end

  def handle_info(_type, state) do
    {:noreply, state}
  end
end
