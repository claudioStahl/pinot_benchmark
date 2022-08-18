defmodule App.Telemetry do
  use Supervisor

  import Telemetry.Metrics

  require Logger

  @buckets [
    1,
    2,
    5,
    10,
    15,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    125,
    150,
    175,
    200,
    250,
    300,
    350,
    400,
    450,
    500,
    600,
    700,
    800,
    900,
    1_000,
    2_000,
    3_000,
    4_000,
    5_000,
    6_000,
    7_000,
    8_000,
    9_000,
    10_000
  ]

  @spec start_link(Keyword.t()) :: Supervisor.on_start()
  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      {TelemetryMetricsPrometheus, metrics: metrics(), port: 4001}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      distribution("finch.request.stop.duration",
        unit: {:native, :millisecond},
        reporter_options: [buckets: @buckets],
        tags: [:status],
        tag_values: &finch_tag_values/1
      ),
      distribution("finch.queue.stop.duration",
        unit: {:native, :millisecond},
        reporter_options: [buckets: @buckets]
      ),
      counter("finch.conn_max_idle_time_exceeded.idle_time")
    ]
  end

  defp finch_tag_values(%{result: {:ok, %{status: status}}}) do
    %{status: to_string(status)}
  end

  defp finch_tag_values(%{result: {:error, _}}) do
    %{status: "error"}
  end
end
