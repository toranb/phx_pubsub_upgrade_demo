defmodule Subpub.Repo do
  use Ecto.Repo,
    otp_app: :subpub,
    adapter: Ecto.Adapters.Postgres
end
