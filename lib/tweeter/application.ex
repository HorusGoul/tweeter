defmodule Tweeter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @app :tweeter

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tweeter.Supervisor]

    minimal_children = [
      # Start the Ecto repository
      Tweeter.Repo
    ]

    children = [
      # Start the Ecto repository
      Tweeter.Repo,
      # Start the Telemetry supervisor
      TweeterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tweeter.PubSub},
      # Start the Endpoint (http/https)
      TweeterWeb.Endpoint
      # Start a worker by calling: Tweeter.Worker.start_link(arg)
      # {Tweeter.Worker, arg}
    ]

    minimal_start = Application.get_env(@app, :minimal, false)

    if minimal_start do
      Supervisor.start_link(minimal_children, opts)
    else
      Supervisor.start_link(children, opts)
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TweeterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
