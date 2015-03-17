require './square'

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