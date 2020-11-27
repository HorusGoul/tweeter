# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tweeter,
  ecto_repos: [Tweeter.Repo],
  generators: [binary_id: true]

config :tweeter, Tweeter.Repo, migration_primary_key: [name: :id, type: :binary_id]

# Configures the endpoint
config :tweeter, TweeterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XYt09fjgRustZJqJoUaFwkDYxp4YlQDlAkH5cBnzHuKSkD89uscQB1y4zALVhjU+",
  render_errors: [view: TweeterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tweeter.PubSub,
  live_view: [signing_salt: "72TubmRN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
