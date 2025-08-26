defmodule SampleHello.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset

  schema "banks" do
    field :code, :string
    field :description, :string
    field :createdBy, :string
    field :lastModifiedBy, :string
    field :versionNumber, :integer
    field :cuit, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:createdBy, :lastModifiedBy, :versionNumber, :code, :cuit, :description])
    |> validate_required([:versionNumber, :code, :cuit, :description])
  end
end
