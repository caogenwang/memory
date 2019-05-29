defmodule RedisWeb.Router do
  use RedisWeb, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end


  pipeline :redis do
    plug(:accepts, ["json"])
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/redis", RedisWeb do
    pipe_through(:redis) # Use the default browser stack

    get "/", PageController, :index
    get "/hello",HelloController,:hello
    post "/info_set",RedisController,:info_set
    get "/info_get",RedisController,:info_get
    get "/info_del",RedisController,:info_del

    post "/key_value_set",RedisController,:key_value_set
    get "/key_value_get",RedisController,:key_value_get
    get "/key_value_del",RedisController,:key_value_del
    post "/key_value_update",RedisController,:key_value_update
  end

  # Other scopes may use custom stacks.
  # scope "/api", RedisWeb do
  #   pipe_through :api
  # end
end
