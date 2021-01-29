# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dsdeliver,
  ecto_repos: [Dsdeliver.Repo]

# Configures the endpoint
config :dsdeliver, DsdeliverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gLitMBXl9SmGj2O4lHHefxrbIxL9TmpwKXltkIx4OzaT3q6jgXRbvC+De5kJqP2m",
  render_errors: [view: DsdeliverWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Dsdeliver.PubSub,
  live_view: [signing_salt: "2/FfuU9q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
