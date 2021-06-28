defmodule PokemonCoutureWeb.PageController do
  use PokemonCoutureWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
