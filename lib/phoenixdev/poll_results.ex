defmodule Phoenixdev.PollResults do
  use GenServer

  alias Phoenix.PubSub

  @pubsub_topic "poll"

  # Client API
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  def vote(option) when option in ["A", "B", "C", "D"] do
    GenServer.cast(__MODULE__, {:vote, option})
  end

  def reset do
    GenServer.cast(__MODULE__, :reset)
  end

  def subscribe_to_updates do
    PubSub.subscribe(Phoenix.PubSub, @pubsub_topic)
  end

  # Server Callbacks
  @initial_state %{"A" => 0, "B" => 0, "C" => 0, "D" => 0}

  def init(_) do
    {:ok, @initial_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def hand_cast({:vote, option}, state) do
    new_state = Map.update!(state, option, &(&1 + 1))

    broadcast_update(new_state)

    {:noreply, new_state}
  end

  def handle_cast(:reset, _state) do
    broadcast_update(@initial_state)
    {:noreply, @initial_state}
  end

  defp broadcast_update(state) do
    PubSub.broadcast(Phoenixdev.PubSub, @pubsub_topic, {:update_results, state})
  end
end
