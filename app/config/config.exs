import Config

config :brod, :clients,
  default: [
    endpoints: [{"localhost", 9092}],
    auto_start_producers: true
  ]
