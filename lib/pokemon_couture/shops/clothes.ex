defmodule PokemonCouture.Shops.Clothes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clothes" do
    field :game, :string
    field :location, :string
    field :name, :string
    many_to_many :users, PokemonCouture.Accounts.User, join_through: "ownerships", unique: :true

    timestamps()
  end

  @doc false
  def changeset(clothes, attrs) do
    clothes
    |> cast(attrs, [:name, :location, :game])
    |> validate_required([:name, :location, :game])
  end
end
