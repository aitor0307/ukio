defmodule UkioWeb.ApartmentController do
  use UkioWeb, :controller

  alias Ukio.Apartments

  action_fallback UkioWeb.FallbackController

  def index(conn, _params) do
    apartments = Apartments.list_apartments()
    render(conn, :index, apartments: apartments)
  end

  #POST
  def create(conn, %{"apartment" => ap_params}) do
    IO.puts("New apartment params: #{inspect(ap_params)}")
    new_apartment = Apartments.create_apartment(ap_params)
    render(conn, :show, new_apartment: new_apartment)
  end

end
