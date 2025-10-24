import Config

config :logger,
  level: :info,
  backends: [:console]

config :logger, :console,
  format: "[$level] $message\n",
  device: :stderr
