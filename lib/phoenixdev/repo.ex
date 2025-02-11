defmodule Phoenixdev.Repo do
  use Ecto.Repo,
    otp_app: :phoenixdev,
    adapter: Ecto.Adapters.Postgres
end
