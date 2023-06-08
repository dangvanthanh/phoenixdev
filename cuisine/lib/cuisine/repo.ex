defmodule Cuisine.Repo do
  use Ecto.Repo,
    otp_app: :cuisine,
    adapter: Ecto.Adapters.Postgres
end
