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

    date_check = check_dates(selected_columns)

    if date_check do
      IO.puts("The date falls within one of the booking date ranges.")
    else
      IO.puts("The date does not fall within any of the booking date ranges.")
    end

    render(conn, :index, bookings: bookings)
  end

  #POST
  def create(conn, %{"booking" => booking_params}) do
      with {:ok, %Booking{} = booking} <- BookingCreator.create(booking_params) do
        conn
        |> put_status(:created)
        |> render(:show, booking: booking)
      end
    end

  def check_dates(date_range) do
    date_to_check = Date.utc_today()
    # check if `date_to_check` falls within any of the booking date ranges
    date_falls_within_range = Enum.any?(date_range, fn {check_in, check_out} ->
      date_to_check >= check_in and date_to_check <= check_out
    end)
  end



end
