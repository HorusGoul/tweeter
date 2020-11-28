defmodule Tweeter.Timeline do
  import Ecto.Query
  alias Tweeter.{Repo, Tweet}

  def types do
    [:home]
  end

  def load_tweets(:home) do
    from(t in Tweet,
      select: t.id,
      order_by: [desc: t.inserted_at]
    )
    |> Repo.all()
  end

  def create_tweet(attrs \\ %{}) do
    %Tweet{}
    |> Tweet.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:tweet_created)
  end

  def update_tweet(%Tweet{} = tweet, attrs) do
    tweet
    |> Tweet.changeset(attrs)
    |> Repo.update()
    |> broadcast(:tweet_updated)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Tweeter.PubSub, "tweets")
  end

  defp broadcast({:error, _reason} = error, _event) do
    error
  end

  defp broadcast({:ok, tweet}, event) do
    Phoenix.PubSub.broadcast(Tweeter.PubSub, "tweets", {event, tweet})
    {:ok, tweet}
  end
end
