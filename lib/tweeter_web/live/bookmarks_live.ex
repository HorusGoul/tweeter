defmodule TweeterWeb.BookmarksLive do
  use TweeterWeb, :live_view

  @impl true
  def mount(_args, session, socket) do
    {:ok, assign_defaults(socket, session)}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end
end
