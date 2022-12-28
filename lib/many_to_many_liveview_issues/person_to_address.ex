defmodule PersonToAddress do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    belongs_to :person, Person
    belongs_to :address, Address
  end

  def changeset(person_to_address, attrs) do
    person_to_address
    |> cast(attrs, [])
    |> cast_assoc(:address)
  end
end
