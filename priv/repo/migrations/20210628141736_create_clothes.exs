defmodule PokemonCouture.Repo.Migrations.CreateClothes do
  use Ecto.Migration

  def change do
    create table(:clothes) do
      add :name, :string
      add :color, :string
      add :type, :string
      add :location, :string
      add :game, :string
      timestamps()
    end

    create table(:ownerships, primary_key: false) do
      add :user_id, references(:users)
      add :clothes_id, references(:clothes)
    end

    create unique_index(:ownerships, [:user_id, :clothes_id])

  end
end
