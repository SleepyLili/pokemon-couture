defmodule PokemonCoutureWeb.Components.ClothesComponent do
  use Phoenix.LiveComponent

  alias PokemonCouture.Shops

  def render(assigns) do
    ~L"""
    <tr>
        <td><%= @clothes.color %></td>
        <td><%= @clothes.game %></td>

        <td>
        <button
        phx-click="toggle-active"
        phx-target="<%= @myself %>"
        >
        <%= if @user in @clothes.users do %>
        X
        <% else %>
        Got it
        <% end %>
        </button>
        </td>
      </tr>
    """
  end


  def handle_event("toggle-active", _value, socket) do
    new_clothes = if socket.assigns.user in socket.assigns.clothes.users do
      Shops.remove_owner(socket.assigns.clothes, socket.assigns.user)
    else
      Shops.add_owner(socket.assigns.clothes, socket.assigns.user)
    end
    socket = assign(socket, :clothes, new_clothes)
    {:noreply, socket}
  end
end
