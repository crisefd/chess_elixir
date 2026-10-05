defmodule Board.BoardTest do
  use ExUnit.Case
  alias ChessElixir.Board.Coordinate
  alias ChessElixir.Board.Board
  import ChessElixir.Board.Board

  # @initial_game_state [
  #   [8, 9, 10, 12, 11, 10, 9, 8],
  #   [7, 7, 7, 7, 7, 7, 7, 7],
  #   [0, 0, 0, 0, 0, 0, 0, 0],
  #   [0, 0, 0, 0, 0, 0, 0, 0],
  #   [0, 0, 0, 0, 0, 0, 0, 0],
  #   [0, 0, 0, 0, 0, 0, 0, 0],
  #   [1, 1, 1, 1, 1, 1, 1, 1],
  #   [2, 3, 4, 6, 5, 4, 3, 2]
  # ]

  test "Creation of new chessboard" do
    expected_new_chessboard = %Board{
      king: [
        %Coordinate{row: 0, column: 3, color: :black},
        %Coordinate{row: 7, column: 3, color: :white}
      ],
      queen: [
        %Coordinate{row: 0, column: 4, color: :black},
        %Coordinate{row: 7, column: 4, color: :white}
      ],
      rook: [
        %Coordinate{row: 0, column: 0, color: :black},
        %Coordinate{row: 0, column: 7, color: :black},
        %Coordinate{row: 7, column: 0, color: :white},
        %Coordinate{row: 7, column: 7, color: :white}
      ],
      bishop: [
        %Coordinate{row: 0, column: 2, color: :black},
        %Coordinate{row: 0, column: 5, color: :black},
        %Coordinate{row: 7, column: 2, color: :black},
        %Coordinate{row: 7, column: 5, color: :black}
      ],
      knight: [
        %Coordinate{row: 0, column: 1, color: :black},
        %Coordinate{row: 0, column: 6, color: :black},
        %Coordinate{row: 7, column: 1, color: :white},
        %Coordinate{row: 7, column: 6, color: :white}
      ],
      pawn: [
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
    }

    board = new()
    assert board == expected_new_chessboard
  end
end
