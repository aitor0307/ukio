defmodule UkioWeb.ApartmentJSON do
  alias Ukio.Apartments.Apartment

  @doc """
  Renders a list of apartments.
  """
  def index(%{apartments: apartments}) do
    %{data: for(apartment <- apartments, do: data(apartment))}
  end

  @doc """
  Renders a single apartment.
  """
  def show(%{new_apartment: {:ok, apartment}}) do
    IO.puts("Show within apartmentjson")
    IO.inspect(apartment)
    %{data: data(apartment)}
  end

  defp data(%Apartment{} = apartment) do
    %{
      id: apartment.id,
      name: apartment.name,
      address: apartment.address,
      zip_code: apartment.zip_code,
      monthly_price: apartment.monthly_price,
      square_meters: apartment.square_meters,
      planet: apartment.planet
    }
  end
end
