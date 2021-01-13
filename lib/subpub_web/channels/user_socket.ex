defmodule SubpubWeb.UserSocket do
  use Phoenix.Socket

  channel "user:*", SubpubWeb.UserChannel

  @impl true
  def connect(%{"token" => token, "sessionId" => session_id}, socket, _connect_info) do
    case Phoenix.Token.verify(socket, "player_auth", token, max_age: 86400) do
      {:ok, current_user} ->
        socket =
          socket
          |> assign(:current_user, current_user)
          |> assign(:session_id, session_id)

        {:ok, socket}

      {:error, _reason} ->
        :error
    end
  end

  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
