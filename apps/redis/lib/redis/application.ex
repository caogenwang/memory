defmodule Redis.Application do
  @moduledoc """
  The Redis Application Service.

  The redis system business domain lives in this application.

  Exposes API to clients such as the `RedisWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Redis.Repo, []),
    ], strategy: :one_for_one, name: Redis.Supervisor)
  end
end
