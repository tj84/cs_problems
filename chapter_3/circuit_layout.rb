require_relative 'csp'

class WordSearchConstraint
    attr_reader :variables
    def initialize(words)
        @variables = words
    end
end

class Csp
    def satisfied?(assignment, constraint)
        all_locations = []
        assignment.each_value do |location|
            location.each do |element|
                all_locations << [element.row, element.column]
            end
        end
        all_locations.uniq.length == all_locations.length
    end
end

class GridLocation
    attr_reader :row
    attr_reader :column
    def initialize(row, column)
        @row = row
        @column = column
    end

    def to_s
        "location is: row: #{@row}, col: #{@column}"
    end
end

class Grid
    attr_reader :grid
    def initialize(rows, columns)
        @grid = []
        fill_grid(rows, columns)
    end

    def to_s
        grid_string = ""
        @grid.each do |row|
            grid_string += "#{row.join}\n"
        end
        grid_string
    end

    def generate_domain(word)
        domain = []
        height = @grid.length
        width = @grid[0].length
        length = word.width
        depth = word.height
        height.times do |row|
            width.times do |column|
                columns = column...(column + length)
                rows = row...(row + length)
                if column + length <= width &&
                    row + depth <= height
                    # left to right
                    locations = []
                    depth.times do |index|
                        columns.each do |col|
                            locations << GridLocation.new(row + index, col)
                        end
                    end
                   domain.append(locations)
                end
                if row + length <= height &&
                    column + depth <= width
                    # top to bottom
                    locations = []
                    depth.times do |index|
                        rows.each do |r|
                            locations << GridLocation.new(r, column + index)
                        end
                    end
                    domain.append(locations)
                end
            end
        end
        domain
    end

    private

    def fill_grid(rows, columns)
        rows.times do
            @grid << ['-'] * columns
        end
    end
end

class Circuit
    attr_accessor :height
    attr_accessor :width
    attr_accessor :value
    def initialize(height, width, value)
        @height = height
        @width = width
        @value = value
    end
end

grid = Grid.new(9,9)
puts grid
puts "*" * 3
words = [Circuit.new(6,1,1), 
        Circuit.new(4,4,2),
        Circuit.new(3,3,3), 
        Circuit.new(2,2,4), 
        Circuit.new(2,5,5)]
locations = {}
words.each do |word|
    locations[word] = grid.generate_domain(word)
end
csp = Csp.new(words, locations)
csp.add_constraint(WordSearchConstraint.new(words))
solution = csp.backtracking_search()
if solution.nil?
    puts "No solution found"
else
    solution.each_pair do |word, locations|
        locations.each do |loc|
            row, col = loc.row, loc.column
            grid.grid[row][col] = word.value
        end
    end
    puts grid
end