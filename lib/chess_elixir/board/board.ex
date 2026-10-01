defmodule ChessElixir.Board.Board do
  alias ChessElixir.Board.Coordinate

  @type piece :: :king | :queen | :rook | :knight | :bishop | :pawn

  @type t :: %__MODULE__{
          king: [Coordinate.t()],
          queen: [Coordinate.t()],
          rook: [Coordinate.t()],
          bishop: [Coordinate.t()],
          knight: [Coordinate.t()],
          pawn: [Coordinate.t()]
        }

  defstruct king: [],
            queen: [],
            rook: [],
            bishop: [],
            knight: [],
            pawn: []

  @spec new() :: t()
  def new() do
    %__MODULE__{
      king: initial_king_coordinates(),
      queen: initial_queen_coordinates(),
      rook: initial_rook_coordinates(),
      bishop: initial_bishop_coordinates(),
      knight: initial_knight_coordinates(),
      pawn: initial_pawn_coordinates()
    }
  end

  @spec lookup_by_piece(piece(), integer(), integer(), t()) :: Coordinate.t()

  def lookup_by_piece(:king, row, column, %{king: coors}) do
    coors
    |> Enum.find(fn coor ->
      coor.row == row && coor.column == column
    end)
  end



  @spec lookup(integer(), integer(), t()) :: Coordinate.t()

  def lookup(row, column, board) do
     [:king, :queen, :rook, :bishop, :knight, :pawn]
     |> do_lookup(row, column, board, nil)

  end

  @spec do_lookup([piece()], integer(), integer(), t(), Coordinate.t()) :: Coordinate.t()

  defp do_lookup([], _row, _colum, _board, result), do: result

  defp do_lookup([piece | pieces], row, column, board, _result) do
    new_result = lookup_by_piece(piece, row, column, board)
    if !new_result  do
      do_lookup(pieces, row, column, board, new_result)
    else
      do_lookup([], row, column, board, new_result)
    end

  end

  defp initial_king_coordinates do
    [%Coordinate{row: 0, column: 3, color: :black}, %Coordinate{row: 7, column: 3, color: :white}]
  end

  defp initial_queen_coordinates do
    [%Coordinate{row: 0, column: 4, color: :black}, %Coordinate{row: 7, column: 4, color: :white}]
  end

  defp initial_rook_coordinates do
    [
      %Coordinate{row: 0, column: 0, color: :black},
      %Coordinate{row: 0, column: 7, color: :black},
      %Coordinate{row: 7, column: 0, color: :white},
      %Coordinate{row: 7, column: 7, color: :white}
    ]
  end

  defp initial_bishop_coordinates do
    [
      %Coordinate{row: 0, column: 2, color: :black},
      %Coordinate{row: 0, column: 5, color: :black},
      %Coordinate{row: 7, column: 2, color: :black},
      %Coordinate{row: 7, column: 5, color: :black}
    ]
  end

  defp initial_knight_coordinates do
    [
      %Coordinate{row: 0, column: 1, color: :black},
      %Coordinate{row: 0, column: 6, color: :black},
      %Coordinate{row: 7, column: 1, color: :white},
      %Coordinate{row: 7, column: 6, color: :white}
    ]
  end

  defp initial_pawn_coordinates do
    [
      %Coordinate{row: 1, column: 0, color: :black},
      %Coordinate{row: 1, column: 1, color: :black},
      %Coordinate{row: 1, column: 2, color: :black},
      %Coordinate{row: 1, column: 3, color: :black},
      %Coordinate{row: 1, column: 4, color: :black},
      %Coordinate{row: 1, column: 5, color: :black},
      %Coordinate{row: 1, column: 6, color: :black},
      %Coordinate{row: 1, column: 7, color: :black},
      %Coordinate{row: 6, column: 0, color: :white},
      %Coordinate{row: 6, column: 1, color: :white},
      %Coordinate{row: 6, column: 2, color: :white},
      %Coordinate{row: 6, column: 3, color: :white},
      %Coordinate{row: 6, column: 4, color: :white},
      %Coordinate{row: 6, column: 5, color: :white},
      %Coordinate{row: 6, column: 6, color: :white},
      %Coordinate{row: 6, column: 7, color: :white}
    ]
  end
end
