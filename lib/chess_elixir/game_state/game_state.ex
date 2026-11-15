defmodule ChessElixir.GameState.GameState do
  alias ChessElixir.Board.Board
  alias ChessElixir.GameState.CapturedLog

  @type t :: %__MODULE__{
         total_elapsed_time: integer(),
         turn: [tuple()],
         board: Board.t() | nil,
         history: [String.t()],
         captured: [tuple()],
         check: :white | :black | nil,
         checkmate: boolean()
        }

  defstruct total_elapsed_time: 0,
            turn: [white: 0, black: 0],
            board: nil,
            history: [],
            captured: [white: %CapturedLog{}, black: %CapturedLog{}],
            check: nil,
            checkmate: false


end
