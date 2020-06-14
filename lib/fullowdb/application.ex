defmodule Fullowdb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      # Start the Ecto repository
      Fullowdb.Repo,
      # Start the Telemetry supervisor
      FullowdbWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Fullowdb.PubSub},
      # Start the Endpoint (http/https)
      FullowdbWeb.Endpoint
      # Start a worker by calling: Fullowdb.Worker.start_link(arg)
      # {Fullowdb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fullowdb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FullowdbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
