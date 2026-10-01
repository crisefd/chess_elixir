defmodule ChessElixir.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChessElixirWeb.Telemetry,
      ChessElixir.Repo,
      {DNSCluster, query: Application.get_env(:chess_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChessElixir.PubSub},
      # Start a worker by calling: ChessElixir.Worker.start_link(arg)
      # {ChessElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      ChessElixirWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChessElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChessElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
