defmodule SubpubWeb.PageController do
  use SubpubWeb, :controller

  def index(conn, _params) do
    user_id = 1
    auth_token = generate_auth_token(conn)
    session_id = get_session(conn, :session_uuid)

    render(conn, "index.html", %{user_id: user_id, auth_token: auth_token, session_id: session_id})
  end

  defp generate_auth_token(conn) do
    current_user = Map.get(conn.assigns, :current_user)
    Phoenix.Token.sign(conn, "player_auth", current_user.id)
  end
end
