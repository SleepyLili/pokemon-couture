# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PokemonCouture.Repo.insert!(%PokemonCouture.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PokemonCouture.Repo
alias PokemonCouture.Shops.Clothes
defmodule Parser do
  def parse do
    File.stream!("sunmoon_clothes.csv")
    |> CSV.decode!(headers: :true)
    |> Enum.map(fn x -> %Clothes{game: x["game"], location: x["location"], name: x["name"], color: x["color"]} end)
    |> Enum.each(fn x -> Repo.insert!(x) end)
  end
end

Repo.insert! %Clothes{game: "Tlapka", location: "Tlapkov", name: "Tlapka Hat", color: "Blue"}
Parser.parse()
