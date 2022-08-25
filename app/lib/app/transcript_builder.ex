defmodule App.TranscriptBuilder do
  alias Faker.Person

  def build(timestamp \\ :now)
  def build(:now), do: do_build(DateTime.utc_now())
  def build(timestamp), do: do_build(timestamp)

  defp do_build(timestamp) do
    %{
      "studentID" => :rand.uniform(1_000),
      "firstName" => Person.first_name(),
      "lastName" => Person.last_name(),
      "gender" => Enum.random(["Female", "Male"]),
      "subject" =>
        Enum.random(["Maths", "History", "Chemistry", "Geography", "English", "Physics"]),
      "score" => :rand.uniform(100) / 10,
      "timestamp" => DateTime.to_unix(timestamp, :millisecond)
    }
  end
end
