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
    _selected_columns = Enum.map(bookings, fn booking ->
      {booking.check_in, booking.check_out}
    end)

    #date_check = check_dates(selected_columns, Date.utc_today(), Date.utc_today())

    #if date_check do
    #  IO.puts("The date falls within one of the booking date ranges.")
    #else
    #  IO.puts("The date does not fall within any of the booking date ranges.")
    #end

    render(conn, :index, bookings: bookings)
  end

  defp check_dates(date_range, check_in, check_out) do
    #date_to_check = Date.utc_today()
    # check if `date_to_check` falls within any of the booking date ranges
    IO.puts("date ranges to check in check_dates: #{inspect(date_range)}")
    result = Enum.map(date_range, fn {existing_check_in, existing_check_out} ->
      IO.puts("Existing booking pairs: #{inspect(existing_check_in)} and #{inspect(existing_check_out)}")
      new_elements = Enum.any?([Date.from_iso8601!(check_in), Date.from_iso8601!(check_out)], fn date_to_check ->
        #date_to_check < existing_check_in or date_to_check > existing_check_out
        IO.puts("date_to_check: #{inspect(date_to_check)} in between #{inspect(existing_check_in)} and #{inspect(existing_check_out)}: #{inspect(Date.compare(date_to_check, existing_check_in) != :lt and Date.compare(date_to_check, existing_check_out) != :gt)}")
        IO.puts(">= check_in: #{inspect(existing_check_in)} is #{inspect(Date.compare(date_to_check, existing_check_in) != :lt)}")
        IO.puts("<= check_out: #{inspect(existing_check_out)} is #{inspect(Date.compare(date_to_check, existing_check_out) != :gt)}")
        Date.compare(date_to_check, existing_check_in) != :lt and Date.compare(date_to_check, existing_check_out) != :gt
      end)
      IO.puts("is booked array: ++ #{inspect([new_elements])}") ##{inspect(result)}
      new_elements
    end)
    IO.inspect(result)
    Enum.any?(result)
  end

  defp extract_dates(bookings) do
    Enum.map(bookings, fn booking ->
      {booking.check_in, booking.check_out}
    end)
  end

  #POST
  def create(conn, %{"booking" => booking_params}) do
    IO.puts("Booking params: #{inspect(booking_params)}")
    IO.puts("Apartment id: #{inspect(booking_params["apartment_id"])}")

    bookings = Apartments.get_apartment_bookings!(booking_params["apartment_id"])
    IO.puts("Apartment bookings: #{inspect(bookings)}")
    selected_columns = extract_dates(bookings)

    IO.puts("Check if dates are booked: #{inspect([booking_params["check_in"], booking_params["check_out"]])}")
    IO.puts("Within: #{inspect(selected_columns)}")
    IO.puts("---------------------------")

    unless Enum.empty?(selected_columns) do
      IO.puts("Check if it is booked")
      is_booked = check_dates(selected_columns,booking_params["check_in"], booking_params["check_out"])
      IO.puts("---------------------------")
      IO.puts("is booked: #{inspect(is_booked)}")
      cond do
        is_booked == true ->
          IO.puts("The date falls within one of the booking date ranges.")
          conn
          |> put_status(:unauthorized)
          |> render(:non_bookable)
        Enum.empty?(selected_columns) == true ->
          IO.puts("The date does not fall within any of the booking date ranges. Create the booking.")
          with {:ok, %Booking{} = booking} <- BookingCreator.create(booking_params) do
            conn
            |> put_status(:created)
            |> render(:show, booking: booking)
          end
        true ->
          IO.puts("The date does not fall within any of the booking date ranges. Create the booking.")
          with {:ok, %Booking{} = booking} <- BookingCreator.create(booking_params) do
            conn
            |> put_status(:created)
            |> render(:show, booking: booking)
          end

      end
    else
      IO.puts("---------------------------")
      IO.puts("Create the booking directly as there is no booking created yet")
      with {:ok, %Booking{} = booking} <- BookingCreator.create(booking_params) do
        conn
        |> put_status(:created)
        |> render(:show, booking: booking)
      end
    end
  end





end
