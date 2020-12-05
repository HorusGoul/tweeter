defmodule TweeterWeb.UserRegistrationController do
  use TweeterWeb, :controller

  import Phoenix.LiveView.Controller

  alias Tweeter.Accounts
  alias TweeterWeb.UserAuth

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :confirm, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, "Invalid input data")
        |> live_render(TweeterWeb.SignUpLive)
    end
  end
end
