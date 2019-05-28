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
  end

  # Other scopes may use custom stacks.
  # scope "/api", RedisWeb do
  #   pipe_through :api
  # end
end
