defmodule PhoenixdevWeb.CookiesLive do
  use PhoenixdevWeb, :live_view

  def render(assigns) do
    # IO.puts("rendering")

    ~H"""
    <div class="flex flex-col items-center justify-center min-h-screen bg-gradient-to-b from-purple-900 to-red-900 text-white">
      <h1 class="absolute top-5 left-5 text-2xl font-bold">Cookie Clicker</h1>
      <div class="text-6xl mb-4">{@count}</div>
      <div
        class="text-9xl cursor-pointer select-none transition-transform duration-100 hover:scale-110 active:scale-90"
        phx-click="increment"
        phx-value-amount="1"
        phx-keydown="increment"
        phx-key="Enter"
        tabindex="0"
      >
        🍪
      </div>
      <div class="mt-10 space-x-4">
        <button
          type="button"
          class="btn btn-primary"
          phx-click="increment"
          phx-value-amount="1"
        >
          +1
        </button>
        <button
          type="button"
          class="btn btn-secondary"
          phx-click="increment"
          phx-value-amount="5"
        >
          +5
        </button>
        <button
          type="button"
          class="btn btn-accent"
          phx-click="increment"
          phx-value-amount="10"
        >
          +10
        </button>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    # if connected?(socket) do
    #   IO.puts("mounting (connected)")
    # else
    #   IO.puts("mounting (not connected)")
    # end

    {:ok, assign(socket, count: 0)}
  end

  def handle_event("increment", %{"amount" => amount}, socket) do
    new_count = socket.assigns.count + String.to_integer(amount)
    {:noreply, assign(socket, :count, new_count)}
  end
end
