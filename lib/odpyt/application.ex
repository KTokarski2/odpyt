defmodule Odpyt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      OdpytWeb.Telemetry,
      # Start the Ecto repository
      Odpyt.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Odpyt.PubSub},
      # Start Finch
      {Finch, name: Odpyt.Finch},
      # Start the Endpoint (http/https)
      OdpytWeb.Endpoint
      # Start a worker by calling: Odpyt.Worker.start_link(arg)
      # {Odpyt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Odpyt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OdpytWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
