defmodule Address do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :road, :string
    has_many :persons_to_addresses, PersonToAddress
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, [:road])
  end
end
