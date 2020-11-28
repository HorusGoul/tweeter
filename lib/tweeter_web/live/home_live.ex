defmodule TweeterWeb.HomeLive do
  use TweeterWeb, :live_view
  use TweeterWeb.Timeline.Realtime, :live_view

  @impl true
  def mount(_args, _session, socket) do
    timeline_subscribe()
    {:ok, socket}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end
end
