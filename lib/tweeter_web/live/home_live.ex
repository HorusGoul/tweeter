defmodule TweeterWeb.HomeLive do
  use TweeterWeb, :live_view

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end
end
