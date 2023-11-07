defmodule PhoenixPad.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_pad,
    adapter: Ecto.Adapters.Postgres
end
