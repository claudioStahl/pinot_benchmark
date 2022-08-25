defmodule App.ProduceManyTranscriptsTask do
  alias App.Producer

  require Logger

  @total 100_000_000
  @parallel 20

  def run do
    Logger.info("#{__MODULE__}.run")

    total = trunc(@total / @parallel)

    1..@parallel
    |> Enum.map(
      &Task.async(fn ->
        produce(&1, total, total)
      end)
    )
    |> Task.await_many(:infinity)
  end

  defp produce(_task_id, 0, _total), do: :ok

  defp produce(task_id, current, total) do
    Logger.info("task #{task_id}: #{current}/#{total}")

    Producer.produce()

    produce(task_id, current - 1, total)
  end
end
