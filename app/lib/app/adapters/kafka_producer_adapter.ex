defmodule App.KafkaProducerAdapter do
  require Logger

  def produce_with_key(topic, key, message, partitioner \\ :phash2, sync \\ false) do
    case :brod.get_partitions_count(:default, topic) do
      {:ok, count} ->
        partition = parse_partition(partitioner, key, count)
        do_produce(topic, message, partition, to_string(key), sync)

      {:error, reason} ->
        Logger.error("#{__MODULE__}.produce error=#{inspect(reason)}")
        {:error, :produce_event_failed}
    end
  end

  def produce(topic, message, sync \\ false) do
    do_produce(topic, message, :random, :undefined, sync)
  end

  defp do_produce(topic, message, partition, key, sync) when sync do
    :default
    |> :brod.produce_sync_offset(
      topic,
      partition,
      key,
      Jason.encode!(message)
    )
    |> case do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.error("#{__MODULE__}.do_produce error=#{inspect(reason)}")
        {:error, :produce_event_failed}
    end
  end

  defp do_produce(topic, message, partition, key, sync) when not sync do
    :default
    |> :brod.produce(
      topic,
      partition,
      key,
      Jason.encode!(message)
    )
    |> case do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.error("#{__MODULE__}.do_produce error=#{inspect(reason)}")
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

  defp hosts, do: Application.get_env(:brod, :clients)[:default][:endpoints]
end
