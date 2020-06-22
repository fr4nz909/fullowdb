# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fullowdb,
  ecto_repos: [Fullowdb.Repo]

# Configures the endpoint
config :fullowdb, FullowdbWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eqXqW746GXD0A62m0O9xq3gPZxuhTXHdqRq/Sg5rCGebjP6BCYwBXK2Gct7Jhnsk",
  render_errors: [view: FullowdbWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Fullowdb.PubSub,
  live_view: [signing_salt: "NwppxvsO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian Config details
config :fullowdb, Fullowdb.Guardian,
       issuer: "fullowdb",
       secret_key: "vgARyGAN6hHLvX1m+Z3FZ1/GwdTd4pfgnnKYK9oPexUtFsuXaY/s4YFbjOxMMVPj"
       # Secret key. You can use `mix guardian.gen.secret` to get one

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
