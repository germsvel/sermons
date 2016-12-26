# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sermons,
  ecto_repos: [Sermons.Repo]

# Configures the endpoint
config :sermons, Sermons.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i5hgf31ltx+Zm0AtA3YRppGnJ6odEy3pBWEkczQsgR8T0Ue/NFO8melIpjUsYxBJ",
  render_errors: [view: Sermons.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sermons.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
