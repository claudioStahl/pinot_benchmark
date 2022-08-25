defmodule App.Producer do
  alias App.KafkaProducerAdapter
  alias App.TranscriptBuilder

  @topic "transcripts"

  def produce(timestamp \\ :now) do
    message = TranscriptBuilder.build(timestamp)
    key = Map.fetch!(message, "studentID")

    KafkaProducerAdapter.produce(@topic, key, message, :modulo)
  end
end
