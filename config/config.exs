# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pokemon_couture,
  ecto_repos: [PokemonCouture.Repo]

# Configures the endpoint
config :pokemon_couture, PokemonCoutureWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cjavc2u/DpOxJYOcHfPIoooejPCwFhD4e5Kp73oPuBQz5jdn0qtwA/ljauvbH1RR",
  render_errors: [view: PokemonCoutureWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PokemonCouture.PubSub,
  live_view: [signing_salt: "a02hEd1K"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
