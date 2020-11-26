defmodule TweeterWeb.TweetComponent do
  use TweeterWeb, :live_component

  def mount(socket) do
    socket =
      socket
      |> assign(:name, "Horus Lugo")
      |> assign(:handle, "HorusGoul")
      |> assign(:text, "Body")

    {:ok, socket}
  end
end
