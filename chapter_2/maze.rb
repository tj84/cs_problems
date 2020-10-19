require_relative 'search.rb'

module Cells
  EMPTY = :" "
  BLOCKED = :X
  START = :S
  GOAL = :G
  PATH = :*
end

class MazeLocation
  attr_reader :row
  attr_reader :column
  def initialize(row, column)
    @row = row
    @column = column
  end

  def ==(x)
    @row == x.row && @column == x.column
  end

  def eql?(x)
    @row == x.row && @column == x.column
  end

  def to_s
    "row: #{@row}, col: #{@column}"
  end

  # needed for set include? method
  def hash
    @row + @column
  end
end

class Maze
  attr_reader :start
  attr_reader :step_counter
  def initialize(start, goal, rows = 10, columns = 10, sparseness = 0.20)
    @rows = rows
    @columns = columns
    @start = start
    @goal = goal
    @grid = []
    @step_counter = 0

    @rows.times do |row|
      @grid << Array.new(@columns)
    end

    random_fill(sparseness)

    @grid[start.row][start.column] = Cells::START
    @grid[goal.row][goal.column] = Cells::GOAL
  end

  def to_s
    output = ""
    @grid.each do |row|
      output += "" + row.join + "\n"
    end
    output
  end

  def mark(path)
    path.each do |maze_location|
      @step_counter += 1
      @grid[maze_location.row][maze_location.column] = Cells::PATH
    end
    @grid[@start.row][@start.column] = Cells::START
    @grid[@goal.row][@goal.column] = Cells::GOAL
  end

  def unmark(path)
    path.each do |maze_location|
      @grid[maze_location.row][maze_location.column] = Cells::EMPTY
    end
    @grid[@start.row][@start.column] = Cells::START
    @grid[@goal.row][@goal.column] = Cells::GOAL
    @step_counter = 0
  end

  def goal_test(current_location)
    current_location == @goal
  end

  def successors(current_location)
    possible_moves = []
    if current_location.row + 1 < @rows &&
      @grid[current_location.row + 1][current_location.column] != Cells::BLOCKED
      possible_moves << MazeLocation.new(current_location.row + 1, 
                                          current_location.column)
    end
    if current_location.row - 1 >= 0 &&
      @grid[current_location.row - 1][current_location.column] != Cells::BLOCKED
      possible_moves << MazeLocation.new(current_location.row - 1, 
                                         current_location.column)
    end
    if current_location.column + 1 < @columns &&
      @grid[current_location.row][current_location.column + 1] != Cells::BLOCKED
      possible_moves << MazeLocation.new(current_location.row, 
                                          current_location.column + 1)
    end
    if current_location.column - 1 >= 0 &&
      @grid[current_location.row][current_location.column - 1] != Cells::BLOCKED
      possible_moves << MazeLocation.new(current_location.row, 
                                          current_location.column - 1)
    end
    possible_moves
  end

  def euclidian_distance(current_location)
    x_distance = current_location.column - @goal.column
    y_distance = current_location.row = @goal.row
    Math.sqrt((x_distance ** 2) + (y_distance ** 2))
  end

  def manhattan_distance(current_location)
    x_distance = (current_location.column - @goal.column).abs
    y_distance = (current_location.row - @goal.row).abs
    x_distance + y_distance
  end

  private

  def random_fill(sparseness)
    @grid.each_with_index do |column, row|
      column.each_with_index do |cell, element|
        if rand() < sparseness
          @grid[row][element] = cell = Cells::BLOCKED
        else
          @grid[row][element] = cell = Cells::EMPTY
        end
      end
    end
  end
end

start = MazeLocation.new(0,0)
goal = MazeLocation.new(9,9)

maze = Maze.new(start, goal,10,10)
puts maze

solution = DFS.new(maze)
unless solution.solution_found
  puts "No solution found using depth-first search!"
else
  puts "Solution found - DFS"
  maze.mark(solution.solution_path)
  puts maze
  puts "Solution took: #{solution.iterations} iterations. Solution is : #{maze.step_counter} steps."
  maze.unmark(solution.solution_path)
end

solution = BFS.new(maze)
unless solution.solution_found
  puts "No solution found using breadth first serch!"
else
  puts "Solution found - BFS"
  maze.mark(solution.solution_path)
  puts maze
  puts "Solution took: #{solution.iterations} iterations. Solution is : #{maze.step_counter} steps."
  maze.unmark(solution.solution_path)
end

solution = Astar.new(maze)
unless solution.solution_found
  puts "No solution found using A* serch!"
else
  puts "Solution found - A*"
  maze.mark(solution.solution_path)
  puts maze
  puts "Solution took: #{solution.iterations} iterations. Solution is : #{maze.step_counter} steps."
  maze.unmark(solution.solution_path)
end
