defmodule CodeCollect.Repo do
  use Ecto.Repo,
    otp_app: :code_collect,
    adapter: Ecto.Adapters.Postgres
end
