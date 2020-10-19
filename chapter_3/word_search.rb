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
        length = word.length
        height.times do |row|
            width.times do |column|
                columns = column...(column + length)
                rows = row...(row + length)
                if column + length <= width
                    # left to right
                    locations = []
                    columns.each do |col|
                        locations << GridLocation.new(row, col)
                    end
                   domain.append(locations)
                    # diagonal towards bottom right
                    if row + length <= height
                        locations = []
                        rows.each do |r|
                            locations << GridLocation.new(r, column + (r - row))
                        end
                        domain.append(locations)
                    end
                end
                if row + length <= height
                    # top to bottom
                    locations = []
                    rows.each do |r|
                        locations << GridLocation.new(r, column)
                    end
                    domain.append(locations)
                    # diagonal towards  bottom left
                    if column - length >= 0
                        locations = []
                        rows.each do |r|
                            locations << GridLocation.new(r, column - (r - row))
                        end
                        domain.append(locations)
                    end
                end
            end
        end
        domain
    end

    private

    def fill_grid(rows, columns)
        rows.times do
            letters = *('A'..'Z')
            @grid << letters.sample(columns)
        end
    end
end


grid = Grid.new(9,9)
puts grid
puts "------"
words = ["matthew", "joe", "mary", "sarah", "sally"]
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
        word.each_char.with_index do |letter, index|
            row, col = locations[index].row, locations[index].column
            grid.grid[row][col] = letter
        end
    end
    puts grid
end