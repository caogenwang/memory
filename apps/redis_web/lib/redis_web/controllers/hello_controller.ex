defmodule RedisWeb.HelloController do
    use RedisWeb, :controller
    use PhoenixSwagger

    swagger_path :hello do
      get "/hello"
      summary "hello"
      description ""
      produces "application/json"
      parameters do
      end
      response 200, "OK"
    end
    def hello(conn, msg) do
      conn |> json(ok(%{meta: %{
          version: to_string(Application.spec(:RedisWeb,:vsn))
      }}))
    end

end
