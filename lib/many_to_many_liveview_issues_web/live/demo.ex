defmodule ManyToManyLiveviewIssuesWeb.Live.Demo do
  use ManyToManyLiveviewIssuesWeb, :live_view

  def render(assigns) do
    ~H"""
      <h1>Hello</h1>
      <.form let={f} for={@changeset} phx-change="form-change">
      <%= text_input f, :name %>
      <% selected_address_ids = get_selected_address_ids(f.source) %>
      <% IO.inspect(selected_address_ids, label: "selected_address_ids") %>
      <%= multiple_select f, :persons_to_addresses, @addresses, selected: selected_address_ids %>
      <%= submit "Save" %>
      </.form>
    """
  end

  defp get_selected_address_ids(changeset) do
    Ecto.Changeset.get_field(changeset, :persons_to_addresses)
    |> Enum.map(fn %{address_id: address_id} -> address_id end)
  end

  def mount(params, session, socket) do
    person = %Person{
      name: "Tim",
      persons_to_addresses: [
        %PersonToAddress{
          address_id: 2,
          address: %Address{id: 2, road: "2nd Street"}
        }
      ]
    }

    addresses = [{"Happy Street", 1}, {"2nd Street", 2}]

    changeset = Person.changeset(person, %{})

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:addresses, addresses)

    {:ok, socket}
  end

  def handle_event("form-change", %{"person" => params}, socket) do
    changeset = Person.changeset(socket.assigns.changeset.data, params)

    # You can see here that the changeset isn't valid if we use the straight list of IDs we get through from the multiple select
    IO.inspect(params, label: "params without manipulation")
    IO.inspect(changeset, label: "changeset without manipulation")

    params =
      update_in(params, ["persons_to_addresses"], fn ids ->
        ids |> Enum.map(fn id -> %{address_id: id} end)
      end)

    changeset = Person.changeset(socket.assigns.changeset.data, params)

    # If we do the above manipulation then we get the changeset with the changes as expected, but in the console you'll see we get an exception thrown
    IO.inspect(params, label: "params with format manipulated")
    IO.inspect(changeset, label: "changeset with format manipulated")

    socket =
      socket
      |> assign(:changeset, changeset)

    {:noreply, socket}
  end
end
