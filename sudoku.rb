require 'minitest/autorun'
require 'minitest/focus'

class Sudoku
  def initialize(board)
    @valid = []
    @board = board
  end

  def is_valid()
    return validate_simple_board if board_line_size == 1
    return false if board_bad_numbers?
    sudoku_indexes = create_empty_map
    sudoku_blocks = []
    @board.each do |line|
      @valid << (line.uniq.size == board_line_size)
      (0..board_line_size - 1).each { |n| sudoku_indexes.fetch(n) << line[n] }
      sudoku_blocks << line.each_slice(3).to_a
    end
    blocks = sudoku_blocks.flatten.each_slice(board_line_size).to_a
    blocks.each do |v|
      @valid << (v.uniq.size == board_line_size)
    end
    sudoku_indexes.each do |k, v|
      @valid << (v.uniq.size == board_line_size) if k < board_line_size
    end
    @valid.all?
  end

  private

  def validate_simple_board
    @board[0] == 1
  end

  def board_bad_numbers?
    @board && @board.flatten.count { |n| n.nil? || !n.is_a?(Integer) || n < 1 } > 0
  end

  def board_line_size
    @board.first.size
  end

  def create_empty_map
    (0...board_line_size).reduce({}) do |hash, n|
      hash[n] = []
      hash
    end
  end

  def create_empty_blocks
    (0..2).reduce({}) do |hash, n|
      hash[n] = []
      hash
    end
  end
end

class SudokuTests < Minitest::Test
  def test_9_x_9_is_valid
    goodSudoku1 = Sudoku.new([
      [7,8,4, 1,5,9, 3,2,6],
      [5,3,9, 6,7,2, 8,4,1],
      [6,1,2, 4,3,8, 7,5,9],

      [9,2,8, 7,1,5, 4,6,3],
      [3,5,7, 8,4,6, 1,9,2],
      [4,6,1, 9,2,3, 5,8,7],

      [8,7,6, 3,9,4, 2,1,5],
      [2,4,3, 5,6,1, 9,7,8],
      [1,9,5, 2,8,7, 6,3,4]

    ])
    assert_equal true,  goodSudoku1.is_valid()
  end

  def test_4_x_4_is_valid
    goodSudoku2 = Sudoku.new([
      [1,4, 2,3],
      [3,2, 4,1],

      [4,1, 3,2],
      [2,3, 1,4]
    ])
    assert_equal true,  goodSudoku2.is_valid()
  end

  def test_invalid_little_squares
    bad_sudoku = Sudoku.new([
      [7,8,0, 1,5,9, 3,2,6],
      [5,3,9, 6,7,1, 8,4,1],
      [6,1,7, 4,1,1, 7,5,9],

      [9,2,9, 7,1,5, 4,6,3],
      [9,5,9, 8,4,6, 1,9,2],
      [9,6,1, 9,2,3, 5,8,7],

      [8,7,6, 3,9,4, 2,1,5],
      [2,4,3, 5,6,1, 9,7,8],
      [1,9,5, 2,3,7, 6,3,4]

    ])
    assert_equal false,  bad_sudoku.is_valid()
  end

  def test_invalid_order_sudoku
    badSudoku1 = Sudoku.new([
      [0,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],

      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],

      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9],
      [1,2,3, 4,5,6, 7,8,9]
    ])
    assert_equal false,  badSudoku1.is_valid()
  end
end
