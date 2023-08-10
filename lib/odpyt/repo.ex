defmodule Odpyt.Repo do
  use Ecto.Repo,
    otp_app: :odpyt,
    adapter: Ecto.Adapters.Postgres
end
