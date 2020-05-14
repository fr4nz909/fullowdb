defmodule Fullowdb.Repo do
  use Ecto.Repo,
    otp_app: :fullowdb,
    adapter: Ecto.Adapters.Postgres
end
