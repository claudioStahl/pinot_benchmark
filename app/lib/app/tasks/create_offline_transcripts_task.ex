defmodule App.CreateOfflineTranscriptsTask do
  alias App.TranscriptBuilder

  @data_path "/tmp/data"
  @start_date ~U[2022-01-01 00:00:00.000000Z]
  @finish_date ~U[2022-02-01 00:00:00.000000Z]
  @interval 1

  def run do
    data_dir = "#{root_dir()}#{@data_path}"

    File.rm_rf!(data_dir)
    File.mkdir_p!(data_dir)

    create_transcript(@start_date)
  end

  defp create_transcript(date, last_data_file \\ nil, last_file \\ nil) do
    month_str = date.month |> to_string() |> String.pad_leading(2, "0")
    day_str = date.day |> to_string() |> String.pad_leading(2, "0")
    hour_str = date.hour |> to_string() |> String.pad_leading(2, "0")
    data_file = "#{root_dir()}#{@data_path}/#{date.year}-#{month_str}-#{day_str}-#{hour_str}.json"

    file = if(last_data_file == data_file, do: last_file, else: File.open!(data_file, [:append]))
    if(last_data_file != data_file, do: File.close(last_file))

    data = TranscriptBuilder.build(date)
    data_str = Jason.encode!(data)

    IO.binwrite(file, "#{data_str}\n")

    new_date = DateTime.add(date, @interval, :second)

    if DateTime.compare(new_date, @finish_date) == :lt do
      create_transcript(new_date, data_file, file)
    else
      :ok
    end
  end

  defp root_dir, do: "#{File.cwd!()}/.."
end
