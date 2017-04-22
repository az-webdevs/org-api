use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :org, Org.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
# `ownership_timeout` allows use of `IEx.pry` for debugging tests
config :org, Org.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "org_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 10 * 60 * 1000
