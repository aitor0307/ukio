defmodule Ukio.Bookings.Handlers.BookingCreator do
  alias Ukio.Apartments

  def create(
        %{"check_in" => check_in, "check_out" => check_out, "apartment_id" => apartment_id} =
          _params
      ) do
    with a <- Apartments.get_apartment!(apartment_id),
         b <- generate_booking_data(a, check_in, check_out) do
      Apartments.create_booking(b)
    end
  end

  defp generate_booking_data(apartment, check_in, check_out) do
    utility_cost = calculate_utilities(apartment)
    %{
      apartment_id: apartment.id,
      check_in: check_in,
      check_out: check_out,
      monthly_rent: apartment.monthly_price,
      utilities: utility_cost,
      deposit: apartment.monthly_price
    }
  end

  defp calculate_utilities(apartment) do
    IO.inspect(apartment.planet)
    case apartment.planet do
      "MARS" ->
        20000 * apartment.square_meters / 100
      "JUPITER" ->
        30000 * apartment.square_meters / 100
      "SATURN" ->
        30000 * apartment.square_meters / 100
      _ ->
        # Default price
        20000
    end
  end
end
