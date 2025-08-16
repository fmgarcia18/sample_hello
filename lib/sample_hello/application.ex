defmodule SampleHello.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SampleHelloWeb.Telemetry,
      SampleHello.Repo,
      {DNSCluster, query: Application.get_env(:sample_hello, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SampleHello.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SampleHello.Finch},
      # Start a worker by calling: SampleHello.Worker.start_link(arg)
      # {SampleHello.Worker, arg},
      # Start to serve requests, typically the last entry
      SampleHelloWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SampleHello.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SampleHelloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
