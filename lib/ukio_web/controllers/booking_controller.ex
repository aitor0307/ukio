defmodule UkioWeb.BookingController do
  use UkioWeb, :controller

  alias Ukio.Apartments
  alias Ukio.Apartments.Booking
  alias Ukio.Bookings.Handlers.BookingCreator

  action_fallback UkioWeb.FallbackController
  require Logger
 #GET
  def show(conn, %{"id" => id}) do
    booking = Apartments.get_booking!(id)
    render(conn, :show, booking: booking)
  end

  #GET

  def index(conn, _params) do
    bookings = Apartments.list_bookings()
    render(conn, :index, bookings: bookings)
  end

  #GET
  def apartmentbookings(conn, %{"id" => id}) do
    bookings = Apartments.get_apartment_bookings!(id)
    selected_columns = Enum.map(bookings, fn booking ->
      {booking.check_in, booking.check_out}
    end)

    date_check = check_dates(selected_columns, [Date.utc_today()])

    if date_check do
      IO.puts("The date falls within one of the booking date ranges.")
    else
      IO.puts("The date does not fall within any of the booking date ranges.")
    end

    render(conn, :index, bookings: bookings)
  end

  defp check_dates(date_range, dates_to_check) do
    #date_to_check = Date.utc_today()
    # check if `date_to_check` falls within any of the booking date ranges
    Enum.any?(dates_to_check, fn date_to_check ->
      Enum.any?(date_range, fn {check_in, check_out} ->
        date_to_check >= check_in and date_to_check <= check_out
        IO.puts("date_to_check: #{inspect(date_to_check)}")
        IO.puts(">= check_in: #{inspect(check_in)}")
        IO.puts("<= check_out: #{inspect(check_out)}")
      end)
    end)
  end

  #POST
  def create(conn, %{"booking" => booking_params}) do
    IO.puts("Booking params: #{inspect(booking_params)}")
    IO.puts("Apartment id: #{inspect(booking_params["apartment_id"])}")

    bookings = Apartments.get_apartment_bookings!(booking_params["apartment_id"])
    selected_columns = Enum.map(bookings, fn booking ->
      {booking.check_in, booking.check_out}
    end)

    IO.puts("Check if dates are booked: #{inspect([booking_params["check_in"], booking_params["check_out"]])}")

    is_booked = check_dates(selected_columns,[booking_params["check_in"], booking_params["check_out"]])

    if is_booked do
      IO.puts("The date falls within one of the booking date ranges.")
      conn
      |> put_status(:unauthorized)
      |> render(:non_bookable)
    else
      IO.puts("The date does not fall within any of the booking date ranges. Create the booking.")
      with {:ok, %Booking{} = booking} <- BookingCreator.create(booking_params) do
        conn
        |> put_status(:created)
        |> render(:show, booking: booking)
      end


    end
  end





end
