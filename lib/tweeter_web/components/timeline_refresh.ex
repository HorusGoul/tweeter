defmodule TweeterWeb.Timeline.Refresh do
  def live_view do
    quote do
      def refresh_timeline_schedule(ms \\ 5000) do
        send_update_after(
          TweeterWeb.TimelineComponent,
          [id: :home],
          ms
        )
      end

      def handle_info({:refresh_timeline_schedule, ms}, socket) do
        refresh_timeline_schedule(ms)

        {:noreply, socket}
      end
    end
  end

  def live_component do
    quote do
      def refresh_timeline_schedule(ms \\ 5000) do
        send(self(), {:refresh_timeline_schedule, ms})
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
