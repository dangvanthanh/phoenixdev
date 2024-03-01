defmodule ShadcnPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :shadcn_phoenix,
    adapter: Ecto.Adapters.Postgres
end
