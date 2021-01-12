defmodule SubpubWeb.PageController do
  use SubpubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
