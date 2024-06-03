# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ukio.Repo.insert!(%Ukio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08007",
  name: "CAPITAN",
  monthly_price: 250_000,
  address: "Carrer de Balmes 76",
  square_meters: 120
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08007",
  name: "GRUMETE",
  monthly_price: 195_000,
  address: "Carrer de Granados 45",
  square_meters: 89
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08001",
  name: "SONOMA",
  monthly_price: 335_000,
  address: "wine county",
  square_meters: 90000
})

Ukio.Repo.insert!(%Ukio.Apartments.Apartment{
  zip_code: "08002",
  name: "CUPERTINO",
  monthly_price: 250_000,
  address: "iphone street 25",
  square_meters: 890
})
