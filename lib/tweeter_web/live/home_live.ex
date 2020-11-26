defmodule TweeterWeb.HomeLive do
  use TweeterWeb, :live_view
  use TweeterWeb.Timeline.Refresh, :live_view

  def mount(args, session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end
end
