defmodule PhoenixPad.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixPadWeb.Telemetry,
      PhoenixPad.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_pad, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixPad.PubSub},
      # Start a worker by calling: PhoenixPad.Worker.start_link(arg)
      # {PhoenixPad.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixPadWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixPad.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixPadWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
