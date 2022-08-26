defmodule App.Repository do
  alias App.PinotBrokerAdapter

  def count_transcript do
    student_id = build_student_id()
    {from_str, to_str} = build_dates()

    "count(*)"
    |> build_query(student_id, from_str, to_str)
    |> PinotBrokerAdapter.query()
  end

  def sum_transcript do
    student_id = build_student_id()
    {from_str, to_str} = build_dates()

    "sum(score)"
    |> build_query(student_id, from_str, to_str)
    |> PinotBrokerAdapter.query()
  end

  defp build_query(select, student_id, from_str, to_str) do
    # """
    # select #{select} from transcript
    # where tsHour >= toEpochHours(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and tsHour <= toEpochHours(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and tsSecond >= toEpochSeconds(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and tsSecond <= toEpochSeconds(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and studentID = #{student_id}
    # """

    # """
    # select #{select} from transcript
    # where tsHour >= toEpochHours(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and tsHour <= toEpochHours(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and studentID = #{student_id}
    # """

    # """
    # select #{select} from transcript
    # where tsSecond >= toEpochSeconds(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and tsSecond <= toEpochSeconds(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and studentID = #{student_id}
    # """

    """
    select #{select} from transcript
    where tsHour >= toEpochHours(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    and tsHour <= toEpochHours(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    and tsMinute >= toEpochMinutes(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    and tsMinute <= toEpochMinutes(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    and studentID = #{student_id}
    """

    # """
    # select #{select} from transcript
    # where tsMinute >= toEpochMinutes(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and tsMinute <= toEpochMinutes(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
    # and studentID = #{student_id}
    # """
  end

  defp build_student_id, do: :rand.uniform(1_000)

  defp build_dates do
    now = NaiveDateTime.utc_now()
    from = NaiveDateTime.add(now, -600, :second)
    to = now
    from_str = from |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
    to_str = to |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()

    {from_str, to_str}
  end
end
