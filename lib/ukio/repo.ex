defmodule Ukio.Repo do
  use Ecto.Repo,
    otp_app: :ukio,
    adapter: Ecto.Adapters.Postgres
end
