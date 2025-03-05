defmodule PhoenixdevWeb.TooltipLive do
  use PhoenixdevWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex justify-center items-center h-screen w-full gap-4">
      <button
        type="button"
        id="example-button"
        phx-hook="TippyHook"
        data-tippy-content="Hello!"
        data-tippy-placement="bottom"
      >
        Bottom
      </button>

      <button
        type="button"
        id="example-button-2"
        phx-hook="TippyHook"
        data-tippy-content="Hello!"
        data-tippy-placement="top"
      >
        Top
      </button>
    </div>
    """
  end
end