defmodule App.Producer do
  alias App.KafkaProducerAdapter

  @topic "transcripts"

  def produce do
    message = %{
      "studentID" => :rand.uniform(10_000),
      "firstName" => Faker.Name.first_name(),
      "lastName" => Faker.Name.last_name(),
      "gender" => Enum.random(["Female", "Male"]),
      "subject" => Enum.random(["Maths", "History", "Chemistry", "Geography", "English", "Physics"]),
      "score" =>  :rand.uniform(100) / 10,
      "timestamp" => DateTime.to_unix(DateTime.utc_now(), :millisecond)
    }

    KafkaProducerAdapter.produce(@topic, message)
  end
end
