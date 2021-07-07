defmodule PokemonCoutureWeb.ClothesController do
  use PokemonCoutureWeb, :controller

  alias PokemonCouture.Shops
  alias PokemonCouture.Shops.Clothes

  def create_shop_map(clothes, map) do
    case map[clothes.location] do
      nil ->
        Map.put(map, clothes.location, [clothes])
      list_of_clothes when is_list(list_of_clothes) ->
        Map.put(map, clothes.location, list_of_clothes ++ [clothes])
    end
  end

  def index(conn, _params) do
    clothes = Shops.list_clothes()
    clothes_map =
      clothes
      |> Enum.reduce(%{}, &create_shop_map/2)
    # IO.inspect(clothes_map)
    render(conn, "index.html", clothes: clothes, clothes_map: clothes_map)
  end

  def new(conn, _params) do
    changeset = Shops.change_clothes(%Clothes{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"clothes" => clothes_params}) do
    case Shops.create_clothes(clothes_params) do
      {:ok, clothes} ->
        conn
        |> put_flash(:info, "Clothes created successfully.")
        |> redirect(to: Routes.clothes_path(conn, :show, clothes))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    clothes = Shops.get_clothes!(id)
    render(conn, "show.html", clothes: clothes)
  end

  def edit(conn, %{"id" => id}) do
    clothes = Shops.get_clothes!(id)
    changeset = Shops.change_clothes(clothes)
    render(conn, "edit.html", clothes: clothes, changeset: changeset)
  end

  def update(conn, %{"id" => id, "clothes" => clothes_params}) do
    clothes = Shops.get_clothes!(id)

    case Shops.update_clothes(clothes, clothes_params) do
      {:ok, clothes} ->
        conn
        |> put_flash(:info, "Clothes updated successfully.")
        |> redirect(to: Routes.clothes_path(conn, :show, clothes))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", clothes: clothes, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    clothes = Shops.get_clothes!(id)
    {:ok, _clothes} = Shops.delete_clothes(clothes)

    conn
    |> put_flash(:info, "Clothes deleted successfully.")
    |> redirect(to: Routes.clothes_path(conn, :index))
  end
end
