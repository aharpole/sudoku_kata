require 'minitest/autorun'
class Board
  def initialize(value_str)
    rows = value_str.scan(/.{9}/)
    rows.each_with_index do |row_str, row|
      row_str.chars.each_with_index do |val, col|
        squares << Square.new(row+1,col+1,val.to_i)
      end
    end
  end
  
  def squares
    @squares ||= []
  end
  
  def to_s
    str = ""
    1.upto(9).each do |row|
      row_str = ""
      1.upto(9).each do |column|
        row_str << value_at(row, column).to_s || '0'
      end
      row_str << "\n"
      str << row_str
    end
    str
  end
  
  def square_at(x,y)
    squares.select {|square| square.x == x}.detect {|square| square.y == y}
  end
  
  def value_at(x,y)
    square_at(x,y).value
  end
  
  def values_matching_criteria(&matcher)
    squares.select(&matcher).map(&:value).reject { |val| val == 0 }
  end
  
  def values_in_row(row)
    values_matching_criteria { |square| square.x == row }
  end
  
  def values_in_column(col)
    values_matching_criteria { |square| square.y == col }
  end
  
  def values_in_box(box)
    values_matching_criteria { |square| square.box == box }
  end
  
  def empty_squares
    squares.select { |square| square.value == 0 }
  end
  
  def legal_values_for_square(square)
    in_same_row = values_in_row square.x
    in_same_column = values_in_column square.y
    in_same_box = values_in_box square.box
    1.upto(9).select {|val| !(in_same_row + in_same_column + in_same_box).include? val}
  end
  
  # Can only solve sudoku puzzles with a unique solution.
  def solve!
    while empty_squares.any?
      square = empty_squares.detect { |square| legal_values_for_square(square).size == 1 }
      square.value = legal_values_for_square(square).first
    end
  end
end

class Square
  attr_reader :x, :y, :value, :box
  def initialize(x,y,value=nil)
    @x, @y, @value = x, y, value
  end
  
  def value=(val)
    @value = val
  end
  
  def box_x
    case x
    when 1, 2, 3 then 1
    when 4, 5, 6 then 2
    when 7, 8, 9 then 3
    end
  end
  
  def box_y
    case y
    when 1, 2, 3 then 1
    when 4, 5, 6 then 2
    when 7, 8, 9 then 3
    end
  end
  
  def box
    "#{box_x} #{box_y}"
  end
end

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