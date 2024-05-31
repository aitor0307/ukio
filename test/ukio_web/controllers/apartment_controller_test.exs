defmodule UkioWeb.ApartmentControllerTest do
  use UkioWeb.ConnCase, async: true

  import Ukio.ApartmentsFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all apartments", %{conn: conn} do
      conn = get(conn, ~p"/api/apartments")
      assert length(json_response(conn, 200)["data"]) == 0
    end
  end

  defp create_apartment(_) do
    apartment = apartment_fixture()
    %{apartment: apartment}
  end
end
