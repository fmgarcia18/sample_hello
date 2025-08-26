defmodule SampleHello.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :createdBy, :string
      add :lastModifiedBy, :string
      add :versionNumber, :integer
      add :code, :string
      add :cuit, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
