defmodule PokemonCoutureWeb.ClothesTrackerLive do
  use PokemonCoutureWeb, :live_view

  alias PokemonCouture.Shops
  alias PokemonCouture.Accounts

  def create_shop_map(clothes, map) do
    case map[clothes.location] do
      nil ->
        Map.put(map, clothes.location, [clothes])
      list_of_clothes when is_list(list_of_clothes) ->
        Map.put(map, clothes.location, list_of_clothes ++ [clothes])
    end
  end

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    clothes_map = Enum.reduce(Shops.list_clothes_with_owners(), %{}, &create_shop_map/2)
    socket =
      socket
      |> assign(:clothes_map, clothes_map)
      |> assign(:user, user)
    {:ok, socket}
  end
end
