defmodule SubpubWeb.UserChannel do
  use SubpubWeb, :channel

  def join("user:" <> user_id, _params, socket) do
    if String.to_integer(user_id) == socket.assigns[:current_user] do
      send(self(), :after_join)

      {:ok, socket}
    else
      {:error, :not_authorized}
    end
  end

  def handle_info(:after_join, %{assigns: %{session_id: session_id}} = socket) do
    {:ok, _} = Registry.register(Subpub.Tracker.Registry, "user_sockets", session_id)

    {:noreply, socket}
  end
end
