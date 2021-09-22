defmodule PokemonCoutureWeb.ClothesTrackerLiveTest do
  # import Plug.Conn
  # use PokemonCoutureWeb.ConnCase
  # import Phoenix.LiveViewTest
  import PokemonCouture.AccountsFixtures
  @endpoint PokemonCoutureWeb.Endpoint

  test "on not login redirect", %{conn: conn} do
    assert {:error, {:redirect, %{to: "/users/log_in"}}} = live(conn, "/tracker")
  end

  test "logged in user sees page", %{conn: conn} do
    conn = conn |> log_in_user(user_fixture())
    {:ok, view, html} = live(conn, "/tracker")
    assert html =~ "Listing Clothes"
  end
end
