defmodule TweeterWeb.Timeline.Realtime do
  def live_view do
    quote do
      def timeline_subscribe do
        Tweeter.Timeline.subscribe()
      end

      def handle_info({:tweet_created, tweet}, socket) do
        Tweeter.Timeline.types()
        |> Enum.each(fn id ->
          send_update(TweeterWeb.TimelineComponent, id: id, new_tweet_id: tweet.id)
        end)

        {:noreply, socket}
      end

      def handle_info({:tweet_updated, tweet}, socket) do
        send_update(TweeterWeb.TweetComponent, id: tweet.id, tweet: tweet)
        {:noreply, socket}
      end
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
