defmodule App.Repository do
  alias App.PinotBrokerAdapter

  def count_transcript do
    student_id = :rand.uniform(10_000)

    PinotBrokerAdapter.query("""
      select count(*) from transcript
      where tsSecond >= toEpochSeconds(fromDateTime('2022-08-17 20:50:40', 'yyyy-MM-dd HH:mm:ss'))
      and tsSecond <= toEpochSeconds(fromDateTime('2022-08-17 20:50:50', 'yyyy-MM-dd HH:mm:ss'))
      and studentID = #{student_id};
    """)
  end

  def sum_transcript do
    student_id = :rand.uniform(10_000)

    PinotBrokerAdapter.query("""
      select sum(score) from transcript
      where tsSecond >= toEpochSeconds(fromDateTime('2022-08-17 20:50:40', 'yyyy-MM-dd HH:mm:ss'))
      and tsSecond <= toEpochSeconds(fromDateTime('2022-08-17 20:50:50', 'yyyy-MM-dd HH:mm:ss'))
      and studentID = #{student_id};
    """)
  end
end
