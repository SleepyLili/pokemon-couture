defmodule PokemonCoutureWeb.Components.ClothesComponent do
  use Phoenix.LiveComponent

  def mount(socket) do
    socket =
      socket
      |> assign(active: true)
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <tr>
        <td><%= @clothes.name %></td>
        <td><%= @clothes.color %></td>
        <td><%= @clothes.game %></td>

        <td>
        <button
        phx-click="toggle-active"
        phx-target="<%= @myself %>"
        >
        <%= if @active do %>
        Got it
        <% else %>
        X
        <% end %>
        </button>
          <!-- here be acquire buton -->
        </td>
      </tr>
    """
  end


  def handle_event("toggle-active", _value, socket) do
    socket =
      socket
      |> assign(:active, not socket.assigns.active)
    {:noreply, socket}
  end
end
