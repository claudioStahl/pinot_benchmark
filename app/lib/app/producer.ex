defmodule App.Producer do
  alias App.KafkaProducerAdapter
  alias Faker.Person

  @topic "transcripts"

  def produce(timestamp \\ :now)
  def produce(:now), do: do_produce(DateTime.utc_now())
  def produce(timestamp), do: do_produce(timestamp)

  defp do_produce(timestamp) do
    key = :rand.uniform(1_000)

    message = %{
      "studentID" => key,
      "firstName" => Person.first_name(),
      "lastName" => Person.last_name(),
      "gender" => Enum.random(["Female", "Male"]),
      "subject" =>
        Enum.random(["Maths", "History", "Chemistry", "Geography", "English", "Physics"]),
      "score" => :rand.uniform(100) / 10,
      "timestamp" => DateTime.to_unix(timestamp, :millisecond)
    }

    KafkaProducerAdapter.produce(@topic, key, message, :modulo)
  end
end
