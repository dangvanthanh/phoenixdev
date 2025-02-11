defmodule Phoenixdev.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixdevWeb.Telemetry,
      Phoenixdev.Repo,
      {DNSCluster, query: Application.get_env(:phoenixdev, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Phoenixdev.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Phoenixdev.Finch},
      # Start a worker by calling: Phoenixdev.Worker.start_link(arg)
      # {Phoenixdev.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixdevWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phoenixdev.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixdevWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
