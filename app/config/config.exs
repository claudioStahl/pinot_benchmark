import Config

config :app,
  topic: "transcripts",
  parallel_consult: System.get_env("PARALLEL_CONSULT", "20") |> String.to_integer(),
  parallel_producer: System.get_env("PARALLEL_PRODUCER", "20") |> String.to_integer(),
  enable_consult_server: System.get_env("ENABLE_CONSULT_SERVER") == "true",
  enable_fixed_producer_server: System.get_env("ENABLE_FIXED_PRODUCER_SERVER") == "true",
  enable_producer_server: System.get_env("ENABLE_PRODUCER_SERVER") == "true"

config :logger, :console, format: "[$level] $message\n"

config :logger, level: :info

config :brod, :clients,
  default: [
    endpoints: [{"localhost", 9092}],
    auto_start_producers: true
  ]
