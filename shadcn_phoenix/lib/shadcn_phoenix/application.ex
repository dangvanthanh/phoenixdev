defmodule ShadcnPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShadcnPhoenixWeb.Telemetry,
      ShadcnPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:shadcn_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ShadcnPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ShadcnPhoenix.Finch},
      # Start a worker by calling: ShadcnPhoenix.Worker.start_link(arg)
      # {ShadcnPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      ShadcnPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShadcnPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShadcnPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
