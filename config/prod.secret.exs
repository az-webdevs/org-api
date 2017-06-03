use Mix.Config

config :org, Org.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :org, Org.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  database: "org_prod",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
