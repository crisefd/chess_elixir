defmodule ChessElixir.Data.SavedFilesManager do
  require IEx
  alias ChessElixir.Board.Board
  alias ChessElixir.Board.Coordinate

  @white_pawn 1
  @white_rook 2
  @white_knight 3
  @white_bishop 4
  @white_queen 5
  @white_king 6

  @black_pawn 7
  @black_rook 8
  @black_knight 9
  @black_bishop 10
  @black_queen 11
  @black_king 12

  @spec load(filename :: binary(), partial_path :: boolean()) :: Board.t()

  def load(filename, false) do
    IO.inspect File.cwd()
    case File.read(filename) do
      {:ok, contents} ->
        {:ok, process(contents)}
      {:error, error} ->
        {:error, error}
    end
  end


  def load(filename, true) do
    path = "../../chess_game_saved_files/#{filename}"
    IO.inspect File.cwd()
    case File.read(path) do
      {:ok, contents} ->
        {:ok, process(contents)}
      {:error, error} ->
        {:error, error}
    end
  end

  defp process(contents) do
    contents
    |> String.split("\n", trim: true)
    |> process_lines()
    |> reduce_to_board()
  end

  defp process_lines(lines) do
    lines
    |> Enum.map(&process_line/1)
  end

  defp process_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  defp reduce_to_board(ls) do
    empty_board = %Board{ king: [], queen: [], bishop: [], knight: [], rook: [], pawn: []}
    [board: board, index: _] =
      ls
      |> Enum.reduce([board: empty_board, index: 0], &reduce_row/2)
    board
  end

  defp reduce_row(row, [board: board, index: row_idx]) do
    [board: new_board, index: _] =
      row
      |> Enum.reduce([ board: board, index: 0 ], fn num, acc ->

        [ board: acc_board, index: acc_idx] = acc
        case num do
          @white_king   -> [board: add_coor(:king,   :white, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @white_queen  -> [board: add_coor(:queen,  :white, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @white_rook   -> [board: add_coor(:rook,   :white, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @white_bishop -> [board: add_coor(:bishop, :white, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @white_knight -> [board: add_coor(:knight, :white, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @white_pawn   -> [board: add_coor(:pawn,   :white, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @black_king   -> [board: add_coor(:king,   :black, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @black_queen  -> [board: add_coor(:queen,  :black, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @black_rook   -> [board: add_coor(:rook,   :black, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @black_bishop -> [board: add_coor(:bishop, :black, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @black_knight -> [board: add_coor(:knight, :black, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          @black_pawn   -> [board: add_coor(:pawn,   :black, acc_board, acc_idx, row_idx), index: acc_idx + 1]
          0 -> [board: acc_board, index: acc_idx + 1]

        end
      end)
    [ board: new_board, index: row_idx + 1]
  end

  defp add_coor(:king, color, %Board{king: king_list} = board, col_idx, row_idx) do
    coor = %Coordinate{row: row_idx, column: col_idx, color: color}
    %{ board | king: [coor | king_list] }
  end

  defp add_coor(:queen, color, %Board{queen: queen_list} = board, col_idx, row_idx) do
    coor = %Coordinate{row: row_idx, column: col_idx, color: color}
    %{ board | queen: [coor | queen_list] }
  end

  defp add_coor(:rook, color, %Board{rook: rook_list} = board, col_idx, row_idx) do
    coor = %Coordinate{row: row_idx, column: col_idx, color: color}
    %{ board | rook: [coor | rook_list] }
  end

  defp add_coor(:bishop, color, %Board{bishop: bishop_list} = board, col_idx, row_idx) do
    coor = %Coordinate{row: row_idx, column: col_idx, color: color}
    %{ board | bishop: [coor | bishop_list] }
  end

  defp add_coor(:knight, color, %Board{knight: knight_list} = board, col_idx, row_idx) do
    coor = %Coordinate{row: row_idx, column: col_idx, color: color}
    %{ board | knight: [coor | knight_list] }
  end

  defp add_coor(:pawn, color, %Board{pawn: pawn_list} = board, col_idx, row_idx) do
    coor = %Coordinate{row: row_idx, column: col_idx, color: color}
    %{ board | pawn: [coor | pawn_list] }
  end


end
