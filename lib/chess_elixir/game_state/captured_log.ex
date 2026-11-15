defmodule ChessElixir.GameState.CapturedLog do

  @type t :: %__MODULE__{
    king: 0 | 1,
    queen: 0 | 1,
    knight: 0 | 1 | 2,
    bishop:  0 | 1 | 2,
    rook:  0 | 1 | 2,
    pawn:  0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8
  }

  defstruct king: 0,
            queen: 0,
            knight: 0,
            bishop: 0,
            rook: 0,
            pawn: 0

end
