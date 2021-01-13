defmodule Subpub.Tracker.Supervisor do
  use Supervisor

  @moduledoc """
  Supervision tree and interface for tracking user sockets
  """

  def start_link(arg \\ []) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_opts \\ []) do
    children = [
      {Registry,
       [keys: :duplicate, name: Subpub.Tracker.Registry, partitions: System.schedulers_online()]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
