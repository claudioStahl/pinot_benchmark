defmodule App.ProduceFixedTranscriptsTask do
  alias App.Producer

  require Logger

  def run do
    Logger.info("#{__MODULE__}.run")

    Producer.produce(~U[2022-08-10 06:00:01.000000Z])
    Producer.produce(~U[2022-08-10 06:00:02.000000Z])
    Producer.produce(~U[2022-08-10 06:00:03.000000Z])
    Producer.produce(~U[2022-08-10 06:00:04.000000Z])
    Producer.produce(~U[2022-08-10 06:00:05.000000Z])
    Producer.produce(~U[2022-08-10 06:00:06.000000Z])
    Producer.produce(~U[2022-08-10 06:00:07.000000Z])
    Producer.produce(~U[2022-08-10 06:00:08.000000Z])

    Producer.produce(~U[2022-08-11 06:00:01.000000Z])
    Producer.produce(~U[2022-08-11 06:00:02.000000Z])
    Producer.produce(~U[2022-08-11 06:00:03.000000Z])
    Producer.produce(~U[2022-08-11 06:00:04.000000Z])
    Producer.produce(~U[2022-08-11 06:00:05.000000Z])
    Producer.produce(~U[2022-08-11 06:00:06.000000Z])
    Producer.produce(~U[2022-08-11 06:00:07.000000Z])
    Producer.produce(~U[2022-08-11 06:00:08.000000Z])

    Producer.produce(~U[2022-08-12 06:00:01.000000Z])
    Producer.produce(~U[2022-08-12 06:00:02.000000Z])
    Producer.produce(~U[2022-08-12 06:00:03.000000Z])
    Producer.produce(~U[2022-08-12 06:00:04.000000Z])
    Producer.produce(~U[2022-08-12 06:00:05.000000Z])
    Producer.produce(~U[2022-08-12 06:00:06.000000Z])
    Producer.produce(~U[2022-08-12 06:00:07.000000Z])
    Producer.produce(~U[2022-08-12 06:00:08.000000Z])

    Producer.produce(~U[2022-08-13 06:00:01.000000Z])
    Producer.produce(~U[2022-08-13 06:00:02.000000Z])
    Producer.produce(~U[2022-08-13 06:00:03.000000Z])
    Producer.produce(~U[2022-08-13 06:00:04.000000Z])
    Producer.produce(~U[2022-08-13 06:00:05.000000Z])
    Producer.produce(~U[2022-08-13 06:00:06.000000Z])
    Producer.produce(~U[2022-08-13 06:00:07.000000Z])
    Producer.produce(~U[2022-08-13 06:00:08.000000Z])

    Producer.produce(~U[2022-08-14 06:00:01.000000Z])
    Producer.produce(~U[2022-08-14 06:00:02.000000Z])
    Producer.produce(~U[2022-08-14 06:00:03.000000Z])
    Producer.produce(~U[2022-08-14 06:00:04.000000Z])
    Producer.produce(~U[2022-08-14 06:00:05.000000Z])
    Producer.produce(~U[2022-08-14 06:00:06.000000Z])
    Producer.produce(~U[2022-08-14 06:00:07.000000Z])
    Producer.produce(~U[2022-08-14 06:00:08.000000Z])

    Producer.produce(~U[2022-08-15 06:00:01.000000Z])
    Producer.produce(~U[2022-08-15 06:00:02.000000Z])
    Producer.produce(~U[2022-08-15 06:00:03.000000Z])
    Producer.produce(~U[2022-08-15 06:00:04.000000Z])
    Producer.produce(~U[2022-08-15 06:00:05.000000Z])
    Producer.produce(~U[2022-08-15 06:00:06.000000Z])
    Producer.produce(~U[2022-08-15 06:00:07.000000Z])
    Producer.produce(~U[2022-08-15 06:00:08.000000Z])
  end
end
