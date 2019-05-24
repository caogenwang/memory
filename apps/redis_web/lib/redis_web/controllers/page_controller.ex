defmodule RedisWeb.PageController do
  use RedisWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
