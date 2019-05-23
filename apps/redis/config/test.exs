use Mix.Config

# Configure your database
config :redis, Redis.Repo,
  adapter: Ecto.Adapters.MySQL,
  database: "dfs_masters",
  username: "root",
  password: "123456",
  hostname: "192.168.2.56",
  port: "4444",
  pool: Ecto.Adapters.SQL.Sandbox
