defmodule ChessElixir.Pieces.Piece do
  alias ChessElixir.Board.Board


  @spec check_axis_move(integer(), integer(), Board.t()) :: boolean()

  def check_axis_move(row, column, board) do
   !!Board.lookup(row, column, board)
  end

end
