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