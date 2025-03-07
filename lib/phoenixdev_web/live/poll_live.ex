defmodule PhoenixdevWeb.PollLive do
  use PhoenixdevWeb, :live_view

  alias Phoenix.PubSub

  def render(assigns) do
    ~H"""
    <div class="bg-indigo-200 w-full h-screen">
      <div class="max-w-2xl mx-auto p-6">
        <div class="bg-white rounded-lg shadow-lg p-6">
          <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Vote in the Poll</h2>

          <div class="space-y-4 mb-6">
            <%= for {option, count} <- @votes do %>
              <div class="w-full">
                <button
                  type="button"
                  phx-click="vote"
                  phx-value-option={option}
                  class="w-full px-6 py-3 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors duration-200 flex justify-between items-center group"
                >
                  <span>Option {option}</span>
                  <span class="bg-gray-100 text-gray-600 px-3 py-1 rounded-full group-hover:bg-gray-200 transition-colors duration-200">
                    {count} votes
                  </span>
                </button>
              </div>
            <% end %>
          </div>

          <div class="text-center">
            <button
              type="button"
              phx-click="reset"
              class="py-2 px-6 bg-red-500 text-white rounded-lg hover:bg-red-600 transition-colors duration-200 font-medium focus:outline-none focus:ring-2 focus:ring-offset-red-500 focus:ring-offset-red-2"
            >
              Reset Poll
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @initial_votes %{"A" => 0, "B" => 0, "C" => 0, "D" => 0}

  @pubsub_topic "poll"

  def mount(_params, _session, socket) do
    PubSub.subscribe(Phoenixdev.PubSub, @pubsub_topic)

    {:ok, assign(socket, votes: @initial_votes)}
  end

  def handle_event("vote", %{"option" => option}, socket) do
    PubSub.broadcast(Phoenixdev.PubSub, @pubsub_topic, {:vote, option})

    {:noreply, socket}
  end

  def handle_event("reset", _params, socket) do
    PubSub.broadcast(Phoenixdev.PubSub, @pubsub_topic, :reset)

    {:noreply, socket}
  end

  def handle_info(:reset, socket) do
    {:noreply, assign(socket, votes: @initial_votes)}
  end

  def handle_info({:vote, option}, socket) do
    new_votes = Map.update!(socket.assigns.votes, option, &(&1 + 1))

    {:noreply, assign(socket, :votes, new_votes)}
  end
end
