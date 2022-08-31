defmodule App.Producer do
  alias App.KafkaProducerAdapter
  alias App.TranscriptBuilder

  @topic Application.fetch_env!(:app, :topic)

  def produce(timestamp \\ :now, sync \\ false) do
    message = TranscriptBuilder.build(timestamp)
    key = Map.fetch!(message, "studentID")

    KafkaProducerAdapter.produce_with_key(@topic, key, message, :modulo, sync)
  end
end
