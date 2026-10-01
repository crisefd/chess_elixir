defmodule ChessElixir.Board.Coordinate do
  @type t :: %__MODULE__{
    row: integer,
    column: integer,
    color: :white | :black
  }

  defstruct row: -1,
            column: -1,
            color: nil

end
