defmodule App.ProduceManyTranscriptsTask do
  alias App.Producer

  require Logger

  @total 500_000_000
  @parallel 20
  @start_date ~U[2022-01-01 00:00:00.000000Z]
  @interval 1

  def run do
    Logger.info("#{__MODULE__}.run")

    total = trunc(@total / @parallel)

    1..@parallel
    |> Enum.map(
      &Task.async(fn ->
        produce(&1, @start_date, total, total)
      end)
    )
    |> Task.await_many(:infinity)
  end

  defp produce(_task_id, _date, 0, _total), do: :ok

  defp produce(task_id, date, current, total) do
    if current == 1 do
      Producer.produce(date, true)
      Logger.info("task #{task_id} finish")
    else
      Producer.produce(date, false)
      Logger.info("task #{task_id}: #{current}/#{total}")
    end

    new_date = DateTime.add(date, @interval, :second)

    produce(task_id, new_date, current - 1, total)
  end
end
