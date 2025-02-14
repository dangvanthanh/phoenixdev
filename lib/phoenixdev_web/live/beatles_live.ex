defmodule PhoenixdevWeb.BeatlesLive do
  use PhoenixdevWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex h-screen bg-slate-200">
      <div class="w-64 bg-slate-700 text-white shadow-md px-4 py-6">
        <h2 class="text-lg font-bold mb-4">
          <a href={~p"/beatles"}>Beatles</a>
          <a href={~p"/albums"} class="text-sm font-normal hover:underline">View Albums</a>
        </h2>
        <ul class="space-y-2">
          <li :for={beatle <- @beatles} class="hover:bg-slate-600 hover:text-white rounded">
            <a href={~p"/beatles/#{beatle}"} class="block p-2 w-full h-full">
              {beatle.name}
            </a>
          </li>
        </ul>
      </div>
      <div class="flex-1 p-6">
        <div :if={@beatle} class="bg-white shadow-md p-4 rounded-lg">
          <img
            src={"/images/" <> @beatle.photo}
            alt={@beatle.name}
            class="w-32 h-32 rounded-full object-cover mb-4"
          />
          <h3 class="text-xl font-bold mb-2">{@beatle.name}</h3>
          <p class="text-gray-600 mb-1"><strong>Instrument:</strong> {@beatle.instrument}</p>
          <p class="text-gray-600 mb-1">
            <strong>Date of Birth:</strong> {Timex.format!(@beatle.dob, "{Mfull} {D}, {YYYY}")}
          </p>
        </div>

        <div :if={!@beatle} class="bg-white shadow-md p-4 rounded-lg">
          Select a beatle from the sidebar
        </div>
      </div>
    </div>
    """
  end

  def mount(params, _session, socket) do
    beatles = Phoenixdev.Beatles.list_beatles()

    beatle =
      case Map.fetch(params, "id") do
        {:ok, id} -> Enum.find(beatles, &(to_string(&1.id) == id))
        :error -> nil
      end

    {:ok, assign(socket, beatle: beatle, beatles: beatles)}
  end
end
