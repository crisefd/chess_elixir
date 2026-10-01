defmodule ChessElixirWeb.PageController do
  use ChessElixirWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
