defmodule Mix.Tasks.App.ProduceTranscripts do
  use Mix.Task

  alias App.Producer

  require Logger

  @requirements ["app.start"]

  @topic "transcripts"
  @total 100_000_000
  @parallel 20

  def run(_args) do
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

    message = %{
      "studentID" => :rand.uniform(10_000),
      "firstName" => "Natalie",
      "lastName" => "Jones",
      "gender" => Enum.random(["Female", "Male"]),
      "subject" => Enum.random(["Maths", "History", "Chemistry", "Geography", "English", "Physics"]),
      "score" =>  :rand.uniform(100) / 10,
      "timestamp" => DateTime.to_unix(DateTime.utc_now(), :millisecond)
    }

    Producer.produce(@topic, message)

    produce(task_id, current - 1, total)
  end
end
