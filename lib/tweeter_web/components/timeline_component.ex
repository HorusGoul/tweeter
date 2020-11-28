defmodule TweeterWeb.TimelineComponent do
  use TweeterWeb, :live_component

  alias Tweeter.{Timeline}

  def update(%{id: _id, new_tweet_id: new_tweet_id}, socket) do
    socket =
      socket
      |> update(:tweet_ids, fn tweet_ids ->
        [new_tweet_id | tweet_ids]
      end)

    {:ok, socket}
  end

  def update(%{id: id}, socket) do
    tweet_ids = Timeline.load_tweets(id)

    socket = socket |> assign(:tweet_ids, tweet_ids)

    {:ok, socket}
  end
end
