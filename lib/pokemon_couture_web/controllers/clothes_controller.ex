defmodule PokemonCoutureWeb.ClothesController do
  use PokemonCoutureWeb, :controller

  alias PokemonCouture.Shops

  def index(conn, _params) do
    clothes_map = Shops.create_shop_map()
    clothes_map = for {shop, map} <- clothes_map
                    do {shop, Enum.reduce(map, %{}, &Shops.inner_map_creator/2)}
                  end
    render(conn, "index.html", clothes_map: clothes_map)
  end

  def show(conn, %{"id" => id}) do
    clothes = Shops.get_clothes!(id)
    render(conn, "show.html", clothes: clothes)
  end
end
