defmodule Dsdeliver.Repo do
  use Ecto.Repo,
    otp_app: :dsdeliver,
    adapter: Ecto.Adapters.Postgres
end
