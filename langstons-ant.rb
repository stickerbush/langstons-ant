# Langton's ant models an ant sitting on a plane of cells, all of which are white initially, facing in one of four directions. Each cell can either be black or white.
# The ant moves according to the color of the cell it is currently sitting in, with the following rules:
#
# - If the cell is black, it changes to white and the ant turns left
# - If the cell is white, it changes to black and the ant turns right
# - The Ant then moves forward to the next cell, and repeat from step 1

# This rather simple ruleset leads to an initially chaotic movement pattern, and after about 10000 steps, a cycle appears where the ant moves steadily away from the 
# starting location in a diagonal corridor about 10 pixels wide. Conceptually the ant can then travel to infinitely far away.

# For this task, start the ant near the center of a 100 by 100 field of cells, which is about big enough to contain the initial chaotic part of the movement. Follow the
# movement rules for the ant, terminate when it moves out of the region, and show the cell colors it leaves behind.



class Ant 
  attr_accessor :position, :direction
  
  def initialize(position, direction)
    @position = position
    @direction = direction
  end
  
  def move(grid)
    # get current cell
    cell = grid.cells[@position[0]][@position[1]]

    # move according to rules
    if (cell.color == :black)
      cell.color = :white
      turn(:left)
      step(@direction)
    elsif (cell.color == :white)
      cell.color = :black
      turn(:right)
      step(@direction)
    end
  end
  
  def on_grid?(grid)
    (@position[0] < grid.size[0] and @position[0] >= 0 and  @position[1] < grid.size[1] and @position[1] >= 0)
  end

  private
  def turn(turn_direction)
    if (turn_direction == :left)
      case (@direction)
      when :north
        @direction = :west
      when :west
        @direction = :south
      when :south
        @direction = :east
      when :east
        @direction = :north
      end
    elsif (turn_direction == :right)
      case (@direction)
      when :north
        @direction = :east
      when :west
        @direction = :north
      when :south
        @direction = :west
      when :east
        @direction = :south
      end
    end
  end

  def step(direction)
    case (direction)
    when :north
      @position[0] +=1
    when :west
      @position[1] -=1 
    when :south
      @position[0] -=1
    when :east
      @position[1] +=1
    end
  end
        
end

class Cell
  attr_accessor :position, :color
  
  def initialize(position, color)
    @position = position
    @color = color
  end
  
end

class Grid
  attr_accessor :size, :cells

  def initialize(size)
    @size = size
    @cells = Array.new(size[0]).each_with_index.map{ |foo, x| Array.new(size[1]) { |y| Cell.new([x,y], :white) } }
  end
end

# set up conditions
grid = Grid.new([100,100])
ant = Ant.new([50, 50], :north)

# move until ant off grid
i = 1
until (!ant.on_grid?(grid))
  ant.move(grid)
  puts("#{i}: #{ant.position[0]},#{ant.position[1]}")
  i += 1
end

