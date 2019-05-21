use Mix.Config

# Configure your database
config :redis, Redis.Repo,
  adapter: Ecto.Adapters.MySQL,
  database: "dfs_masters",
  username: "root",
  password: "123456",
  hostname: "0.0.0.0",
  port: "14444",
  pool: Ecto.Adapters.SQL.Sandbox
