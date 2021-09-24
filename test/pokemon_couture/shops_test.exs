defmodule PokemonCouture.ShopsTest do
  use PokemonCouture.DataCase

  alias PokemonCouture.Shops

  import PokemonCouture.AccountsFixtures
  describe "clothes" do
    alias PokemonCouture.Shops.Clothes

    @valid_attrs %{game: "some game", location: "some location", type: "shirt", name: "some name", color: "some color"}
    @update_attrs %{game: "some updated game", location: "some updated location", type: "hat", name: "some updated name", color: "some updated color"}
    @invalid_attrs %{game: nil, location: nil, name: nil, color: nil}

    def clothes_fixture(attrs \\ %{}) do
      {:ok, clothes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shops.create_clothes()

      clothes
    end

    test "list_clothes/0 returns non-empty list" do
      assert length(Shops.list_clothes()) > 0
    end

    test "valid piece of clothing in list_clothes/0" do
      clothes = Shops.get_clothes!(1)
      assert clothes in Shops.list_clothes()
    end

    test "get_clothes!/1 returns the clothes with given id" do
      clothes = clothes_fixture()
      assert Shops.get_clothes!(clothes.id) == clothes
    end

    test "create_clothes/1 with valid data creates a clothes" do
      assert {:ok, %Clothes{} = clothes} = Shops.create_clothes(@valid_attrs)
      assert clothes.game == "some game"
      assert clothes.location == "some location"
      assert clothes.name == "some name"
    end

    test "create_clothes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shops.create_clothes(@invalid_attrs)
    end

    test "update_clothes/2 with valid data updates the clothes" do
      clothes = clothes_fixture()
      assert {:ok, %Clothes{} = clothes} = Shops.update_clothes(clothes, @update_attrs)
      assert clothes.game == "some updated game"
      assert clothes.location == "some updated location"
      assert clothes.name == "some updated name"
    end

    test "update_clothes/2 with invalid data returns error changeset" do
      clothes = clothes_fixture()
      assert {:error, %Ecto.Changeset{}} = Shops.update_clothes(clothes, @invalid_attrs)
      assert clothes == Shops.get_clothes!(clothes.id)
    end

    test "delete_clothes/1 deletes the clothes" do
      clothes = clothes_fixture()
      assert {:ok, %Clothes{}} = Shops.delete_clothes(clothes)
      assert_raise Ecto.NoResultsError, fn -> Shops.get_clothes!(clothes.id) end
    end

    test "change_clothes/1 returns a clothes changeset" do
      clothes = clothes_fixture()
      assert %Ecto.Changeset{} = Shops.change_clothes(clothes)
    end

    test "check if list clothes with owners has owners" do
      clothes_with_owners = Shops.list_clothes_with_owners()
      clothes_piece = hd(clothes_with_owners)
      assert clothes_piece.users
    end

    test "clothes owner adding and removing test" do
      clothes_piece = hd(Shops.list_clothes_with_owners())
      user = user_fixture()
      clothes_piece = Shops.add_owner(clothes_piece, user)
      assert user in clothes_piece.users
      clothes_piece = Shops.remove_owner(clothes_piece, user)
      assert user not in clothes_piece.users
    end
  end
end
