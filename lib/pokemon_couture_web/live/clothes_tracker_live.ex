defmodule PokemonCoutureWeb.ClothesTrackerLive do
  use PokemonCoutureWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:light_bulb_status, "off")
      |> assign(:on_button_status, "")
      |> assign(:off_button_status, "disabled")

    {:ok, socket}
  end

  def handle_event("on", _value, socket) do
    socket =
      socket
      |> assign(:light_bulb_status, "on")
      |> assign(:on_button_status, "disabled")
      |> assign(:off_button_status, "enabled")

    {:noreply, socket}
  end

  def handle_event("off", _value, socket) do
    socket =
      socket
      |> assign(:light_bulb_status, "off")
      |> assign(:on_button_status, "")
      |> assign(:off_button_status, "disabled")

    {:noreply, socket}
    end
end
