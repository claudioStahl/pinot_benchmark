defmodule Mix.Tasks.App.ProduceTranscripts do
  use Mix.Task

  alias App.Producer

  require Logger

  @requirements ["app.start"]

  @topic "transcripts"
  @total 1_000_000

  def run(_args) do
    Logger.info("#{__MODULE__}.run")

    produce(@total)
  end

  defp produce(0), do: :ok

  defp produce(current) do
    Logger.info("#{current}/#{@total}")

    message = %{
      "studentID" => :rand.uniform(100),
      "firstName" => "Natalie",
      "lastName" => "Jones",
      "gender" => Enum.random(["Female", "Male"]),
      "subject" => Enum.random(["Maths", "History", "Chemistry", "Geography", "English", "Physics"]),
      "score" =>  :rand.uniform(100) / 10,
      "timestamp" => DateTime.to_unix(DateTime.utc_now(), :millisecond)
    }

    Producer.produce(@topic, message)

    produce(current - 1)
  end
end
