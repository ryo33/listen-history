# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :musiclog,
  ecto_repos: [Musiclog.Repo]

# Configures the endpoint
config :musiclog, Musiclog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SfnZ2PH7OqZRv1RKLtLV5Vktr9qKWKm1mnk875o6iHDUdjYdyXPbV2cPKKcnbuoC",
  render_errors: [view: Musiclog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Musiclog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Musiclog",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET_KEY") || "abcdef",
  serializer: Musiclog.UserSerializer

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
