defmodule App.Producer do
  alias App.KafkaProducerAdapter
  alias Faker.Person

  @topic "transcripts"

  def produce do
    key = :rand.uniform(1_000)

    message = %{
      "studentID" => key,
      "firstName" => Person.first_name(),
      "lastName" => Person.last_name(),
      "gender" => Enum.random(["Female", "Male"]),
      "subject" =>
        Enum.random(["Maths", "History", "Chemistry", "Geography", "English", "Physics"]),
      "score" => :rand.uniform(100) / 10,
      "timestamp" => DateTime.to_unix(DateTime.utc_now(), :millisecond)
    }

    KafkaProducerAdapter.produce(@topic, key, message, :modulo)
  end
end
