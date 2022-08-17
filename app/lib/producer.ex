defmodule App.Producer do
  require Logger

  def produce(topic, message) do
    :default
    |> :brod.produce(
      topic,
      :random,
      :undefined,
      Jason.encode!(message)
    )
    |> case do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.error("#{__MODULE__}.produce error=#{inspect(reason)}")
        {:error, :produce_event_failed}
    end
  catch
    _type, error ->
      Logger.error("""
      Error while publishing to Kafka.
      Reason: #{inspect(error)}
      Stacktrace: #{__STACKTRACE__}
      """)

      {:error, :produce_event_failed}
  end
end
