defmodule App.ProduceFixedTranscriptsTask do
  alias App.Producer

  require Logger

  def run do
    Logger.info("#{__MODULE__}.run")

    Producer.produce(~U[2022-08-01 00:00:01.000000Z])
    Producer.produce(~U[2022-08-01 00:00:02.000000Z])
    Producer.produce(~U[2022-08-01 00:00:03.000000Z])
    Producer.produce(~U[2022-08-01 00:00:04.000000Z])
    Producer.produce(~U[2022-08-01 00:00:05.000000Z])
    Producer.produce(~U[2022-08-01 00:00:06.000000Z])
    Producer.produce(~U[2022-08-01 00:00:07.000000Z])
    Producer.produce(~U[2022-08-01 00:00:08.000000Z])

    Producer.produce(~U[2022-08-01 01:00:01.000000Z])
    Producer.produce(~U[2022-08-01 01:00:02.000000Z])
    Producer.produce(~U[2022-08-01 01:00:03.000000Z])
    Producer.produce(~U[2022-08-01 01:00:04.000000Z])
    Producer.produce(~U[2022-08-01 01:00:05.000000Z])
    Producer.produce(~U[2022-08-01 01:00:06.000000Z])
    Producer.produce(~U[2022-08-01 01:00:07.000000Z])
    Producer.produce(~U[2022-08-01 01:00:08.000000Z])

    Producer.produce(~U[2022-08-01 02:00:01.000000Z])
    Producer.produce(~U[2022-08-01 02:00:02.000000Z])
    Producer.produce(~U[2022-08-01 02:00:03.000000Z])
    Producer.produce(~U[2022-08-01 02:00:04.000000Z])
    Producer.produce(~U[2022-08-01 02:00:05.000000Z])
    Producer.produce(~U[2022-08-01 02:00:06.000000Z])
    Producer.produce(~U[2022-08-01 02:00:07.000000Z])
    Producer.produce(~U[2022-08-01 02:00:08.000000Z])

    Producer.produce(~U[2022-08-01 03:00:01.000000Z])
    Producer.produce(~U[2022-08-01 03:00:02.000000Z])
    Producer.produce(~U[2022-08-01 03:00:03.000000Z])
    Producer.produce(~U[2022-08-01 03:00:04.000000Z])
    Producer.produce(~U[2022-08-01 03:00:05.000000Z])
    Producer.produce(~U[2022-08-01 03:00:06.000000Z])
    Producer.produce(~U[2022-08-01 03:00:07.000000Z])
    Producer.produce(~U[2022-08-01 03:00:08.000000Z])

    Producer.produce(~U[2022-08-01 04:00:01.000000Z])
    Producer.produce(~U[2022-08-01 04:00:02.000000Z])
    Producer.produce(~U[2022-08-01 04:00:03.000000Z])
    Producer.produce(~U[2022-08-01 04:00:04.000000Z])
    Producer.produce(~U[2022-08-01 04:00:05.000000Z])
    Producer.produce(~U[2022-08-01 04:00:06.000000Z])
    Producer.produce(~U[2022-08-01 04:00:07.000000Z])
    Producer.produce(~U[2022-08-01 04:00:08.000000Z])

    Producer.produce(~U[2022-08-01 05:00:01.000000Z])
    Producer.produce(~U[2022-08-01 05:00:02.000000Z])
    Producer.produce(~U[2022-08-01 05:00:03.000000Z])
    Producer.produce(~U[2022-08-01 05:00:04.000000Z])
    Producer.produce(~U[2022-08-01 05:00:05.000000Z])
    Producer.produce(~U[2022-08-01 05:00:06.000000Z])
    Producer.produce(~U[2022-08-01 05:00:07.000000Z])
    Producer.produce(~U[2022-08-01 05:00:08.000000Z])
  end
end
