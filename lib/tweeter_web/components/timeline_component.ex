defmodule TweeterWeb.TimelineComponent do
  use TweeterWeb, :live_component
  use TweeterWeb.Timeline.Refresh, :live_component

  import Ecto.Query
  alias Tweeter.{Tweet, Repo}

  def update(assigns, socket) do
    result =
      case assigns.id do
        :home ->
          load_home_tweets(socket)
      end

    refresh_timeline_schedule()

    result
  end

  defp load_home_tweets(socket) do
    tweet_ids =
      from(t in Tweet,
        select: t.id,
        order_by: [desc: t.inserted_at]
      )
      |> Repo.all()

    socket = socket |> assign(:tweet_ids, tweet_ids)

    # TODO: Cache last tweet time so we can decide whether to
    # update or not

    {:ok, socket}
  end
end
