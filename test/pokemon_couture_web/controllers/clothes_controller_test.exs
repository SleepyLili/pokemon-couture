defmodule PokemonCoutureWeb.ClothesControllerTest do
  use PokemonCoutureWeb.ConnCase

  alias PokemonCouture.Shops

  @create_attrs %{game: "some game", location: "some location", type: "hat", name: "some name", color: "some color"}
  @update_attrs %{game: "some updated game", location: "some updated location", type: "shirt", name: "some updated name", colo: "some updated color"}
  @invalid_attrs %{game: nil, location: nil, type: "no", name: nil, color: nil}

  def fixture(:clothes) do
    {:ok, clothes} = Shops.create_clothes(@create_attrs)
    clothes
  end

  describe "index" do
    test "lists all clothes", %{conn: conn} do
      conn = get(conn, Routes.clothes_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Clothes"
    end
  end

  defp create_clothes(_) do
    clothes = fixture(:clothes)
    %{clothes: clothes}
  end
end
