require_relative 'csp'

class QueensConstraint
    attr_reader :variables
    def initialize(columns)
        @variables = columns
    end
end

class Csp
    def satisfied?(assignment, constraint)
         assignment.each_pair do |first_queen_col, first_queen_row|
            start = (first_queen_col + 1)
            end_range = (constraint.variables.length)
            (start..end_range).each do |second_queen_col|
                if assignment.has_key?(second_queen_col)
                    second_queen_row = assignment[second_queen_col]
                    if second_queen_row == first_queen_row
                        return false
                    end
                    if (first_queen_row - second_queen_row).abs == 
                        (first_queen_col - second_queen_col).abs
                        return false
                    end
                end
            end
        end
        return true
    end
end

columns = [*1..8]
rows = Hash.new
columns.each do |column|
    rows[column] = [*1..8]
end

csp = Csp.new(columns, rows)
csp.add_constraint(QueensConstraint.new(columns))
solution = csp.backtracking_search()
if solution.nil?
    puts "No solution"
else
    puts solution
end