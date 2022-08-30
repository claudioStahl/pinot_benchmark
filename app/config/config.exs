import Config

config :app,
  parallel_consult: System.get_env("PARALLEL_CONSULT", "20") |> String.to_integer(),
  parallel_producer: System.get_env("PARALLEL_PRODUCER", "20") |> String.to_integer()

config :logger, :console, format: "[$level] $message\n"

config :logger, level: :info

config :brod, :clients,
  default: [
    endpoints: [{"localhost", 9092}],
    auto_start_producers: true
  ]
