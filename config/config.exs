# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :org,
  ecto_repos: [Org.Repo]

# Configures the endpoint
config :org, Org.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qi2C19PRuDvzdVnLNm1gqKo0bYESopuDbcDQJc7GTs2iCq27QzXZ2y+lWoGq41yO",
  render_errors: [view: Org.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Org.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# # Configure phoenix generators
# config :phoenix, :generators,
#   migration: false,
#   binary_id: true

config :org, GitHub,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET"),
  redirect_uri: System.get_env("GITHUB_REDIRECT_URI")
