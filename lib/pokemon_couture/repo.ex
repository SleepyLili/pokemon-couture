defmodule PokemonCouture.Repo do
  use Ecto.Repo,
    otp_app: :pokemon_couture,
    adapter: Ecto.Adapters.Postgres
end
