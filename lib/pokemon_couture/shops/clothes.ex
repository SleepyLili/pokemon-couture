defmodule PokemonCouture.Shops.Clothes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clothes" do
    field :name, :string
    field :color, :string
    field :game, :string
    field :location, :string

    many_to_many :users, PokemonCouture.Accounts.User, join_through: "ownerships", unique: :true

    timestamps()
  end

  @doc false
  def changeset(clothes, attrs) do
    clothes
    |> cast(attrs, [:name, :location, :game, :color])
    |> validate_required([:name, :location, :game, :color])
  end
end
