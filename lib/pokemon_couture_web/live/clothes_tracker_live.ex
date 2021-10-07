defmodule PokemonCoutureWeb.ClothesTrackerLive do
  use PokemonCoutureWeb, :live_view

  alias PokemonCouture.Shops
  alias PokemonCouture.Accounts

  def mount(_params, %{"user_token" => user_token} = _session, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    clothes_map = Shops.create_shop_map()
    clothes_map = for {shop, map} <- clothes_map
                    do {shop, Enum.reduce(map, %{}, &Shops.inner_map_creator/2)}
                  end
    socket =
      socket
      |> assign(:clothes_map, clothes_map)
      |> assign(:user, user)
    {:ok, socket}
  end
end
