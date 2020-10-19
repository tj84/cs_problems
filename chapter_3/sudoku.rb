require_relative 'csp'

GRID_SIZE = 9

class SudokuConstraint
    attr_reader :variables
    def initialize(locations)
        @variables = locations
    end
end

class Csp
    def satisfied?(assignment, constraint)
        # rows can't have duplicates
        # any value in rows assigned or constraint can't be duplicate
        rows = {}
        assignment.each do |key, value|
            rows[key.row] ||= [] 
            rows[key.row] << value
        end
        constraint.variables.each do |location|
            rows[location.row] ||= []
            if location.value != -1 && !assignment.has_key?(location)
                rows[location.row] << location.value
            end
        end
        rows.each do |key, value|
            if value.flatten.length != value.flatten.uniq.length
                return false
            end
        end
        # cols can't have duplicates
        cols = {}
        assignment.each do |key, value|
            cols[key.column] ||= [] 
            cols[key.column] << value
        end
        constraint.variables.each do |location|
            cols[location.column] ||= []
            if location.value != -1 && !assignment.has_key?(location)
                cols[location.column] << location.value
            end
        end
        cols.each do |key, value|
            if value.flatten.length != value.flatten.uniq.length
                return false
            end
        end
        # boxes can't have duplicates
        boxes = {}
        assignment.each do |key, value|
            boxes[key.box] ||= [] 
            boxes[key.box] << value
        end
        constraint.variables.each do |location|
            boxes[location.box] ||= []
            if location.value != -1 && !assignment.has_key?(location)
                boxes[location.box] << location.value
            end
        end
        boxes.each do |key, value|
            if value.flatten.length != value.flatten.uniq.length
                return false
            end
        end
        return true
    end
end

class GridLocation
    attr_reader :row
    attr_reader :column
    attr_reader :box
    attr_accessor :value
    def initialize(row, column, value = -1)
        @row = row
        @column = column
        @value = value
        row_temp = (@row / 3) * 3
        col_temp = (@column / 3)
        @box = row_temp + col_temp
    end
end

grid = []

GRID_SIZE.times do |row|
    GRID_SIZE.times do |col|
        grid << GridLocation.new(row, col)
    end
end

values = {}
grid.each do |location|
    values[location] = *(1..GRID_SIZE)
end

# add in fixed values
keys = values.keys
values[keys[0]] = [3]
values[keys[2]] = [4]
values[keys[7]] = [2]
values[keys[8]] = [9]
values[keys[11]] = [2]
values[keys[13]] = [4]
values[keys[14]] = [9]
values[keys[16]] = [5]
values[keys[17]] = [8]
values[keys[19]] = [1]
values[keys[20]] = [9]
values[keys[21]] = [2]
values[keys[24]] = [3]
values[keys[27]] = [2]
values[keys[30]] = [6]
values[keys[31]] = [8]
values[keys[32]] = [3]
values[keys[35]] = [1]
values[keys[37]] = [7]
values[keys[38]] = [8]
values[keys[40]] = [1]
values[keys[45]] = [9]
values[keys[46]] = [3]
values[keys[48]] = [4]
values[keys[52]] = [6]
values[keys[53]] = [5]
values[keys[55]] = [8]
values[keys[57]] = [7]
values[keys[58]] = [6]
values[keys[61]] = [1]
values[keys[62]] = [2]
values[keys[63]] = [4]
values[keys[65]] = [7]
values[keys[68]] = [2]
values[keys[69]] = [5]
values[keys[72]] = [1]
values[keys[73]] = [2]
values[keys[79]] = [3]

# add fixed vlaues to actual grid
grid[0].value = [3]
grid[2].value = [4]
grid[7].value = [2]
grid[8].value = [9]
grid[11].value = [2]
grid[13].value = [4]
grid[14].value = [9]
grid[16].value = [5]
grid[17].value = [8]
grid[19].value = [1]
grid[20].value = [9]
grid[21].value = [2]
grid[24].value = [3]
grid[27].value = [2]
grid[30].value = [6]
grid[31].value = [8]
grid[32].value = [3]
grid[35].value = [1]
grid[37].value = [7]
grid[38].value = [8]
grid[40].value = [1]
grid[45].value = [9]
grid[46].value = [3]
grid[48].value = [4]
grid[52].value = [6]
grid[53].value = [5]
grid[55].value = [8]
grid[57].value = [7]
grid[58].value = [6]
grid[61].value = [1]
grid[62].value = [2]
grid[63].value = [4]
grid[65].value = [7]
grid[68].value = [2]
grid[69].value = [5]
grid[72].value = [1]
grid[73].value = [2]
grid[79].value = [3]

csp = Csp.new(grid, values)
csp.add_constraint(SudokuConstraint.new(grid))
solution = csp.backtracking_search()
if solution.nil?
    puts "No solution"
else
    grid_string = ""
    solution.each_value.with_index do |value, index|
        grid_string += value.to_s
        if (index + 1) % GRID_SIZE == 0
            grid_string += "\n"
        end
    end
    puts grid_string
end
