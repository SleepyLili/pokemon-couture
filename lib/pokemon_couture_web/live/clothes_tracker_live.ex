defmodule PokemonCoutureWeb.ClothesTrackerLive do
  use PokemonCoutureWeb, :live_view

  alias PokemonCouture.Shops
  alias PokemonCouture.Accounts
  alias PokemonCouture.Shops.Clothes

  def create_shop_map(clothes, map) do
    case map[clothes.location] do
      nil ->
        Map.put(map, clothes.location, %{clothes.type => [clothes]})
      map_of_clothes when is_map(map_of_clothes) ->
        map_of_clothes = case map_of_clothes[clothes.type] do
          nil ->
            Map.put(map_of_clothes, clothes.type, [clothes])
          list_of_clothes when is_list(list_of_clothes) ->
            Map.put(map_of_clothes, clothes.type, [clothes | list_of_clothes])
        end
        Map.put(map, clothes.location, map_of_clothes)
    end
  end

  def assign_clothespiece_to_map(clothes, map) do
    case map[clothes.name] do
      nil ->
        Map.put(map, clothes.name, [clothes])
      list_of_clothes when is_list(list_of_clothes) ->
        Map.put(map, clothes.name, [clothes | list_of_clothes])
    end
  end

  def inner_map_creator({type, list}, acc) do
    clothes_map = Enum.reduce(list, %{}, &assign_clothespiece_to_map/2)
    Map.put(acc, type, clothes_map)
  end

  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    clothes_map = Enum.reduce(Shops.list_clothes_with_owners(), %{}, &create_shop_map/2)
    clothes_map = for {shop, map} <- clothes_map
                  do {shop, Enum.reduce(map, %{}, &inner_map_creator/2)}
                  end
    socket =
      socket
      |> assign(:clothes_map, clothes_map)
      |> assign(:user, user)
    {:ok, socket}
  end
end
