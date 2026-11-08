defmodule ChessElixir.Pieces.Piece do
  alias ChessElixir.Board.Board
  alias ChessElixir.Board.Coordinate


  def check_rook_move(init_row, init_col, end_row, end_col, board) do
    {_, %Coordinate{color: init_color}} = Board.lookup(init_row, init_col, board)
    {content, end_coor} = Board.lookup(end_row, end_col, board)
    is_end_square_empty? = content == :empty
    is_enemy_in_end_square? = !is_end_square_empty? && init_color !== end_coor.color
    is_horizontal? = init_row == end_row && init_col !== end_col
    is_vertical? = init_row !== end_row && init_col == end_col
    (is_vertical? || is_horizontal?) && (is_end_square_empty? || is_enemy_in_end_square?)
  end

  def check_bishop_move(init_row, init_col, end_row, end_col, board) do
    {_, %Coordinate{color: init_color}} = Board.lookup(init_row, init_col, board)
    {content, end_coor} = Board.lookup(end_row, end_col, board)
    is_end_square_empty? = content == :empty
    is_enemy_in_end_square? = !is_end_square_empty? && init_color !== end_coor.color

    is_north_west? = end_row < init_row && end_col < init_col
    is_north_east? = end_row < init_row && end_col > init_col
    is_south_west? = end_row > init_row && end_col < init_col
    is_south_east? = end_row > init_row && end_col > init_col

    (is_north_west? ||  is_north_east? ||  is_south_west? || is_south_east?)
            && (is_end_square_empty? || is_enemy_in_end_square?)

  end

  def check_queen_move(init_row, init_col, end_row, end_col, board) do
    check_rook_move(init_row, init_col, end_row, end_col, board)
           || check_bishop_move(init_row, init_col, end_row, end_col, board)
  end

  def check_pawn_move(init_row, init_col, end_row, end_col, board) do
    {:pawn, %Coordinate{color: init_color}} = Board.lookup(init_row, init_col, board)
    {content, end_coor} = Board.lookup(end_row, end_col, board)
    is_end_square_empty? = content == :empty

    is_first_move? = (init_color == :black && init_col == 1) || (init_color == :white && init_col == 6)

    is_enemy_in_end_square? = !is_end_square_empty? && init_color !== end_coor.color
    is_two_squares_forward? = Kernel.abs(init_row - end_row) == 2 && Kernel.abs(init_col - end_col) == 0
    is_one_square_forward? = Kernel.abs(init_row - end_row) == 2 && Kernel.abs(init_col - end_col) == 0
    is_one_square_diagonal_forward? = Kernel.abs(init_row - end_row) == 1 && Kernel.abs(init_col - end_col) == 1

    (is_one_square_forward? && is_end_square_empty?)
          || (is_two_squares_forward? && is_first_move?)
          || (is_one_square_diagonal_forward? && is_enemy_in_end_square?)

  end

  def check_king_move(init_row, init_col, end_row, end_col, board) do
    {:king, %Coordinate{color: init_color}} = Board.lookup(init_row, init_col, board)
    {content, end_coor} = Board.lookup(end_row, end_col, board)
    is_end_square_empty? = content == :empty
    is_enemy_in_end_square? = !is_end_square_empty? && init_color !== end_coor.color
    is_one_square_omnidirectional? = Kernel.abs(init_row - end_row) == 1 || Kernel.abs(init_col - end_col) == 1

    (is_one_square_omnidirectional? && is_end_square_empty?) || (is_one_square_omnidirectional? && is_enemy_in_end_square?)

  end

  def check_knight_move(init_row, init_col, end_row, end_col, board) do

    {:knight, %Coordinate{color: init_color}} = Board.lookup(init_row, init_col, board)
    {content, end_coor} = Board.lookup(end_row, end_col, board)
    is_end_square_empty? = content == :empty
    is_enemy_in_end_square? = !is_end_square_empty? && init_color !== end_coor.color

    vertical_diff = Kernel.abs(init_row - end_row)
    horizontal_diff = Kernel.abs(init_col - end_col)

    is_L_shaped_move? = (vertical_diff == 3 && horizontal_diff == 1) || (vertical_diff == 1 && horizontal_diff == 3)
    (is_L_shaped_move? && is_end_square_empty?) || (is_L_shaped_move? && is_enemy_in_end_square?)

  end



end
