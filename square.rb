class Square
  attr_reader :x, :y, :value, :box
  def initialize(x,y,value=nil)
    @x, @y, @value = x, y, value
  end
  
  def value=(val)
    @value = val
  end
  
  def box_for_coordinate(coordinate)
    case coordinate
    when 1, 2, 3 then 1
    when 4, 5, 6 then 2
    when 7, 8, 9 then 3
    end
  end
  
  def box
    "#{box_for_coordinate(x)} #{box_for_coordinate(y)}"
  end
end