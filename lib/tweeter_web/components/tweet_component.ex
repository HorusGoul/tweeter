defmodule TweeterWeb.TweetComponent do
  use TweeterWeb, :live_component

  import Ecto.Query
  alias Tweeter.{Tweet, Repo}

  def preload(list_of_assigns) do
    list_of_ids = Enum.map(list_of_assigns, & &1.id)

    tweets =
      from(t in Tweet,
        where: t.id in ^list_of_ids,
        select: {t.id, t}
      )
      |> Repo.all()
      |> Map.new()

    Enum.map(list_of_assigns, fn assigns ->
      Map.put(assigns, :tweet, tweets[assigns.id])
    end)
  end

  @spec mount(Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(socket) do
    socket =
      socket
      |> assign(:name, "Horus Lugo")
      |> assign(:handle, "HorusGoul")

    {:ok, socket}
  end
end
