defmodule RedisWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use RedisWeb, :controller
      use RedisWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: RedisWeb
      import Plug.Conn
      import RedisWeb.Router.Helpers
      import RedisWeb.Gettext
      def ok(msg), do: %{status: :ok, content: msg}
      def error(code, reason), do: %{status: :error, content: %{code: code, reason: reason}}
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/redis_web/templates",
                        namespace: RedisWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import RedisWeb.Router.Helpers
      import RedisWeb.ErrorHelpers
      import RedisWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import RedisWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
