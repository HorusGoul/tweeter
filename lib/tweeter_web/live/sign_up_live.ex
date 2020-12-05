defmodule TweeterWeb.SignUpLive do
  use TweeterWeb, :live_view

  alias Tweeter.Accounts
  alias Tweeter.Accounts.User

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{changeset: Accounts.change_user_registration(%User{})})}
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      %User{}
      |> User.registration_changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end
end
