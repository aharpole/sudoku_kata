require 'minitest/autorun'
require './sudoku'

class TestBoard < MiniTest::Test
  def setup
    @board = Board.new('105802000090076405200400819019007306762083090000061050007600030430020501600308900')
  end
  def test_creation_and_to_s
    assert_equal "105802000\n090076405\n200400819\n019007306\n762083090\n000061050\n007600030\n430020501\n600308900\n" , @board.to_s
  end
  
  def test_values_in_row
    assert_includes @board.values_in_row(1), 1
    assert_includes @board.values_in_row(1), 5
    assert_includes @board.values_in_row(1), 8
    assert_includes @board.values_in_row(3), 8
  end
  
  def test_values_in_col
    assert_includes @board.values_in_column(1), 1
    assert_includes @board.values_in_column(1), 7
    assert_includes @board.values_in_column(4), 8
  end
  
  def test_legal_values_for_square
    square = @board.square_at(1,5)
    assert(!@board.legal_values_for_square(square).include?(8))
    assert(!@board.legal_values_for_square(square).include?(7))
  end
end

# 105802000
# 090076405
# 200400819
# 019007306
# 762083090
# 000061050
# 007600030
# 430020501
# 600308900