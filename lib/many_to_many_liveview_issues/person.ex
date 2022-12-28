defmodule Person do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :name, :string
    has_many :persons_to_addresses, PersonToAddress
  end

  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name])
    |> cast_assoc(:persons_to_addresses)
  end
end
