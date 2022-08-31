defmodule App.ConsultServer do
  use GenServer

  require Logger

  alias App.Repository

  def build_children do
    enable_consult_server = Application.fetch_env!(:app, :enable_consult_server)
    parallel_consult = Application.fetch_env!(:app, :parallel_consult)

    if enable_consult_server && parallel_consult > 0 do
      Enum.map(1..parallel_consult, &{__MODULE__, number: &1})
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
    send(self(), :consult)

    {:ok, options}
  end

  def handle_info(:consult, state) do
    case Repository.sum_transcript() do
      {:ok, _} ->
        send(self(), :consult)

      {:error, _} ->
        Process.send_after(self(), :consult, 5_000)
    end

    {:noreply, state}
  end

  def handle_info(_type, state) do
    {:noreply, state}
  end
end
