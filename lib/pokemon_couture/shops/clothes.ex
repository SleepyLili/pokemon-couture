defmodule PokemonCouture.Shops.Clothes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clothes" do
    field :name, :string
    field :color, :string
    field :type, :string # shirt, bottoms, socks, shoes, bag, hat, eyewear, hair accessory
    field :game, :string
    field :location, :string
    many_to_many :users, PokemonCouture.Accounts.User, join_through: "ownerships", unique: :true, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(clothes, attrs) do
    clothes
    |> cast(attrs, [:name, :location, :type, :game, :color])
    |> validate_required([:name, :location, :type, :game, :color])
    |> validate_format(:type, ~r/(shirt)|(bottoms)|(socks)|(shoes)|(bag)|(hat)|(eyewear)|(hair accessory)/)
  end
end
