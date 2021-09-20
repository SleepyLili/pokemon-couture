defmodule PokemonCoutureWeb.ClothesControllerTest do
  use PokemonCoutureWeb.ConnCase

  alias PokemonCouture.Shops

  @create_attrs %{game: "some game", location: "some location", name: "some name", color: "some color"}
  @update_attrs %{game: "some updated game", location: "some updated location", name: "some updated name", colo: "some updated color"}
  @invalid_attrs %{game: nil, location: nil, name: nil, color: nil}

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

  # describe "new clothes" do
  #   test "renders form", %{conn: conn} do
  #     conn = get(conn, Routes.clothes_path(conn, :new))
  #     assert html_response(conn, 200) =~ "New Clothes"
  #   end
  # end

  # describe "create clothes" do
  #   test "redirects to show when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.clothes_path(conn, :create), clothes: @create_attrs)

  #     assert %{id: id} = redirected_params(conn)
  #     assert redirected_to(conn) == Routes.clothes_path(conn, :show, id)

  #     conn = get(conn, Routes.clothes_path(conn, :show, id))
  #     assert html_response(conn, 200) =~ "Show Clothes"
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.clothes_path(conn, :create), clothes: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "New Clothes"
  #   end
  # end

  describe "edit clothes" do
    setup [:create_clothes]

    test "renders form for editing chosen clothes", %{conn: conn, clothes: clothes} do
      conn = get(conn, Routes.clothes_path(conn, :edit, clothes))
      assert html_response(conn, 200) =~ "Edit Clothes"
    end
  end

  describe "update clothes" do
    setup [:create_clothes]

    test "redirects when data is valid", %{conn: conn, clothes: clothes} do
      conn = put(conn, Routes.clothes_path(conn, :update, clothes), clothes: @update_attrs)
      assert redirected_to(conn) == Routes.clothes_path(conn, :show, clothes)

      conn = get(conn, Routes.clothes_path(conn, :show, clothes))
      assert html_response(conn, 200) =~ "some updated game"
    end

    test "renders errors when data is invalid", %{conn: conn, clothes: clothes} do
      conn = put(conn, Routes.clothes_path(conn, :update, clothes), clothes: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Clothes"
    end
  end

  describe "delete clothes" do
    setup [:create_clothes]

    test "deletes chosen clothes", %{conn: conn, clothes: clothes} do
      conn = delete(conn, Routes.clothes_path(conn, :delete, clothes))
      assert redirected_to(conn) == Routes.clothes_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.clothes_path(conn, :show, clothes))
      end
    end
  end

  defp create_clothes(_) do
    clothes = fixture(:clothes)
    %{clothes: clothes}
  end
end
