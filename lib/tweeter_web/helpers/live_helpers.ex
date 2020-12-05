defmodule TweeterWeb.LiveHelpers do
  import Phoenix.LiveView

  alias Tweeter.Accounts

  def assign_defaults(socket, session) do
    socket
    |> assign_auth(session)
  end

  def assign_auth(socket, session) do
    socket =
      case session do
        %{"user_token" => token} ->
          user = Accounts.get_user_by_session_token(token)

          socket |> assign(:current_user, user)

        _ ->
          socket |> assign(:current_user, nil)
      end

    socket
  end
end
