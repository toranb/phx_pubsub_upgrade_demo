defmodule SubpubWeb.Router do
  use SubpubWeb, :router

  def validate_session(conn, _opts) do
    case get_session(conn, :session_uuid) do
      nil ->
        conn |> put_session(:session_uuid, Ecto.UUID.generate())

      _ ->
        conn
    end
  end

  def require_session(conn, _opts) do
    case get_session(conn, :session_uuid) do
      nil ->
        conn |> halt()

      _ ->
        user_id = 1
        assign(conn, :current_user, %{id: user_id})
    end
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :validate_session
  end

  pipeline :restricted do
    plug :browser
    plug :require_session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SubpubWeb do
    pipe_through :restricted

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SubpubWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: SubpubWeb.Telemetry
    end
  end
end
