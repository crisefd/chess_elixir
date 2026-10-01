defmodule ChessElixir.Repo do
  use Ecto.Repo,
    otp_app: :chess_elixir,
    adapter: Ecto.Adapters.Postgres
end
