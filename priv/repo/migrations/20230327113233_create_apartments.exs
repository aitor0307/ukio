defmodule Ukio.Repo.Migrations.CreateApartments do
  use Ecto.Migration

  def change do
    create table(:apartments) do
      add :name, :string
      add :address, :string
      add :zip_code, :string
      add :monthly_price, :integer
      add :square_meters, :integer
      add :planet, :string, default: "EARTH", null: false

      timestamps()
    end
  end
end
