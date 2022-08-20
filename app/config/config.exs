import Config

config :logger, :console, format: "[$level] $message\n"

config :logger, level: :info

config :brod, :clients,
  default: [
    endpoints: [{"localhost", 9092}],
    auto_start_producers: true
  ]
