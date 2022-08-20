defmodule App.KafkaProducerAdapter do
  require Logger

  def produce(topic, key, message, partitioner \\ :phash2) do
    {:ok, count} = :brod.get_partitions_count(:default, topic)
    partition = parse_partition(partitioner, key, count)

    :default
    |> :brod.produce(
      topic,
      partition,
      to_string(key),
      Jason.encode!(message)
    )
    |> case do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.error("#{__MODULE__}.produce error=#{inspect(reason)}")
        {:error, :produce_event_failed}
    end
  end

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
  end

  defp parse_partition(:murmur, key, count) do
    key
    |> App.Utils.Murmur.murmur2()
    |> rem(count)
    |> abs()
  end

  defp parse_partition(:modulo, key, count) do
    key
    |> rem(count)
    |> abs()
  end

  defp parse_partition(:phash2, key, count) do
    key
    |> :erlang.phash2()
    |> rem(count)
    |> abs()
  end
end
