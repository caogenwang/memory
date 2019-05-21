use Mix.Config

config :redis, ecto_repos: [Redis.Repo]

import_config "#{Mix.env}.exs"
