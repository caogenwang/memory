defmodule Redis.Application do
  @moduledoc """
  The Redis Application Service.

  The redis system business domain lives in this application.

  Exposes API to clients such as the `RedisWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application
  @password  "123456"
  @redis_urls [
    "redis://:#{@password}@localhost:7001/",
    "redis://:#{@password}@localhost:7002/",
    "redis://:#{@password}@localhost:7003/"
  ]
  def start(_type, _args) do
    import Supervisor.Spec, warn: false


    Supervisor.start_link([
      supervisor(Redis.Repo, []),
      supervisor(Redis.Start, [@redis_urls]),
    ], strategy: :one_for_one, name: Redis.Supervisor)
  end
end
