defmodule App.Repository do
  alias App.PinotBrokerAdapter

  def count_transcript do
    student_id = build_student_id()
    {from_str, to_str} = build_dates()

    PinotBrokerAdapter.query("""
      select count(*) from transcript
      where tsSecond >= toEpochSeconds(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
      and tsSecond <= toEpochSeconds(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
      and studentID = #{student_id};
    """)
  end

  def sum_transcript do
    student_id = build_student_id()
    {from_str, to_str} = build_dates()

    PinotBrokerAdapter.query("""
      select sum(score) from transcript
      where tsSecond >= toEpochSeconds(fromDateTime('#{from_str}', 'yyyy-MM-dd HH:mm:ss'))
      and tsSecond <= toEpochSeconds(fromDateTime('#{to_str}', 'yyyy-MM-dd HH:mm:ss'))
      and studentID = #{student_id};
    """)
  end

  defp build_student_id, do: :rand.uniform(1_000)

  defp build_dates do
    now = NaiveDateTime.utc_now()
    from = NaiveDateTime.add(now, -20, :second)
    to = NaiveDateTime.add(from, 10, :second)
    from_str = from |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
    to_str = to |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()

    {from_str, to_str}
  end
end
