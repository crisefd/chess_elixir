defmodule SavedFilesManager.SavedFilesManagerTest do
  use ExUnit.Case
  alias ChessElixir.Board.Board
  import ChessElixir.Data.SavedFilesManager

  test "Reading non existent saved file" do
    {result_atom, _} = load("non_existent_file.txt", true)
    assert result_atom == :error
  end


  test "Reading game state saved file" do
    expected = Board.new()
    {:ok, board} = load("./test/assets/saved_game_0.txt", false)

    Enum.each(board.king, fn coor ->
      assert coor in expected.king
    end)

  end
end
