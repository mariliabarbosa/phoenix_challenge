defmodule PhoenixChallenge.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_challenge,
    adapter: Ecto.Adapters.Postgres
end
