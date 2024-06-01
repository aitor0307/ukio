defmodule Ukio.Apartments.Apartment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apartments" do
    field :address, :string
    field :monthly_price, :integer
    field :name, :string
    field :square_meters, :integer
    field :zip_code, :string
    field :planet, :string, default: "EARTH"

    timestamps()
  end

  @doc false
  def changeset(apartment, attrs) do
    apartment
    |> cast(attrs, [:name, :address, :zip_code, :monthly_price, :square_meters, :planet])
    |> validate_required([:name, :address, :zip_code, :monthly_price, :square_meters])
    |> put_default_planet()
  end

  defp put_default_planet(changeset) do
    case get_field(changeset, :planet) do
      nil -> put_change(changeset, :planet, "EARTH")
      _ -> changeset
    end
  end
end
