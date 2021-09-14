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

  def add_owner(clothes, user) do
    clothes
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, [user | clothes.users])
    |> Repo.update!()
  end

  def remove_owner(clothes, user) do
    clothes
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:users, List.delete(clothes.users, user))
    |> Repo.update!()
  end
end
