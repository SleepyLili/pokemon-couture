defmodule PokemonCouture.Shops do
  @moduledoc """
  The Shops context.
  """

  import Ecto.Query, warn: false
  alias PokemonCouture.Repo

  alias PokemonCouture.Shops.Clothes

  @doc """
  Returns the list of clothes.

  ## Examples

      iex> list_clothes()
      [%Clothes{}, ...]

  """
  def list_clothes do
    Repo.all(Clothes)
  end

  @doc """
  Returns the list of clothes with owners preloaded.
  """
  def list_clothes_with_owners do
    Repo.all(from c in Clothes, preload: [:users])
  end
  @doc """
  Gets a single clothes.

  Raises `Ecto.NoResultsError` if the Clothes does not exist.

  ## Examples

      iex> get_clothes!(123)
      %Clothes{}

      iex> get_clothes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clothes!(id), do: Repo.get!(Clothes, id)

  @doc """
  Creates a clothes.

  ## Examples

      iex> create_clothes(%{field: value})
      {:ok, %Clothes{}}

      iex> create_clothes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clothes(attrs \\ %{}) do
    %Clothes{}
    |> Clothes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clothes.

  ## Examples

      iex> update_clothes(clothes, %{field: new_value})
      {:ok, %Clothes{}}

      iex> update_clothes(clothes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clothes(%Clothes{} = clothes, attrs) do
    clothes
    |> Clothes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clothes.

  ## Examples

      iex> delete_clothes(clothes)
      {:ok, %Clothes{}}

      iex> delete_clothes(clothes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clothes(%Clothes{} = clothes) do
    Repo.delete(clothes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clothes changes.

  ## Examples

      iex> change_clothes(clothes)
      %Ecto.Changeset{data: %Clothes{}}

  """
  def change_clothes(%Clothes{} = clothes, attrs \\ %{}) do
    Clothes.changeset(clothes, attrs)
  end

  @doc """
  Adds a new owner to a piece of clothing.
  """
  def add_owner(clothes, user) do
    clothes
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, [user | clothes.users])
    |> Repo.update!()
  end

  @doc """
  Removes an owner from a piece of clothing.
  """
  def remove_owner(clothes, user) do
    clothes
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, List.delete(clothes.users, user))
    |> Repo.update!()
  end

  @doc """
  Creates a a shop map.
  %{location -> %{type -> [clothes_of_loc_and_type]}}
  """
  def create_shop_map() do
    Enum.reduce(list_clothes_with_owners(), %{}, &sort_clothes_to_map/2)
  end

  defp sort_clothes_to_map(clothes, map) do
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

  defp assign_clothespiece_to_map(clothes, map) do
    case map[clothes.name] do
      nil ->
        Map.put(map, clothes.name, [clothes])
      list_of_clothes when is_list(list_of_clothes) ->
        Map.put(map, clothes.name, [clothes | list_of_clothes])
    end
  end

  @doc """
  Sorts inner maps created with create_shop_map(),
  putting each in a different map by clothes name, then sorting by game name.
  Resulting big map: %{location -> %{type -> %{name -> sorted_list_of_clothes}}}
  """
  def inner_map_creator({type, list}, acc) do
    clothes_map = Enum.reduce(list, %{}, &assign_clothespiece_to_map/2)
    clothes_map = for {shop, map} <- clothes_map
                   do {shop, Enum.sort_by(map, fn %Clothes{game: game} -> game end)}
                  end
    Map.put(acc, type, clothes_map)
  end

end
