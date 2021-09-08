defmodule PokemonCoutureWeb.ClothesTrackerLive do
  use PokemonCoutureWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :light_bulb_status, "off")
    {:ok, socket}
  end

  def handle_event("on", _value, socket) do
    socket =
      socket
      |> assign(:light_bulb_status, "on")

    {:noreply, socket}
  end
end
