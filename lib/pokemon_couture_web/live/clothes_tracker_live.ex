defmodule PokemonCoutureWeb.ClothesTrackerLive do
  use PokemonCoutureWeb, :live_view

  alias PokemonCouture.Shops
  alias PokemonCouture.Shops.Clothes
  alias PokemonCouture.Live.Components.ClothesComponent

  def create_shop_map(clothes, map) do
    case map[clothes.location] do
      nil ->
        Map.put(map, clothes.location, [clothes])
      list_of_clothes when is_list(list_of_clothes) ->
        Map.put(map, clothes.location, list_of_clothes ++ [clothes])
    end
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:light_bulb_status, "off")
      |> assign(:on_button_status, "")
      |> assign(:off_button_status, "disabled")
      |> assign(:active, true)
      |> assign(:clothes_map, Enum.reduce(Shops.list_clothes(), %{}, &create_shop_map/2))
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

end
