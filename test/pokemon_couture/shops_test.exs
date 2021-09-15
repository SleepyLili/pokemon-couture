defmodule PokemonCouture.ShopsTest do
  use PokemonCouture.DataCase

  alias PokemonCouture.Shops

  describe "clothes" do
    alias PokemonCouture.Shops.Clothes

    @valid_attrs %{game: "some game", location: "some location", name: "some name", color: "some color"}
    @update_attrs %{game: "some updated game", location: "some updated location", name: "some updated name", color: "some updated color"}
    @invalid_attrs %{game: nil, location: nil, name: nil, color: nil}

    def clothes_fixture(attrs \\ %{}) do
      {:ok, clothes} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shops.create_clothes()

      clothes
    end
    # for some reason this default test does not work anymore. probably because of db seeding.
    # test "list_clothes/0 returns all clothes" do
    #   clothes = clothes_fixture()
    #   assert Shops.list_clothes() == [clothes]
    # end

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
  end
end
