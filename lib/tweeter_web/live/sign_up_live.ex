defmodule TweeterWeb.SignUpLive do
  use TweeterWeb, :live_view

  alias Tweeter.Accounts
  alias Tweeter.Accounts.User
  alias TweeterWeb.UserAuth

  def mount(_params, %{"changeset" => changeset} = _session, socket) do
    {:ok, assign(socket, %{changeset: changeset})}
  end

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

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.register_user(params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(socket, :confirm, &1)
          )

        {:noreply,
         socket
         |> put_flash(:info, "User created")
         |> UserAuth.log_in_user(user)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
