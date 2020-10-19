require_relative 'csp'

class MapColoringConstraint
    attr_reader :variables
    attr_reader :place1
    attr_reader :place2
    def initialize(place1, place2)
        @variables = [place1, place2]
        @place1 = place1
        @place2 = place2
    end
end


class Csp
    def satisfied?(assignment, constraint)
        if !assignment.include?(constraint.place1) || !assignment.include?(constraint.place2)
            return true
        end
        assignment[constraint.place1] != assignment[constraint.place2]
    end
end

variables = ["Western Australia", "Northern Territory", "South Australia",
"Queensland", "New South Wales", "Victoria", "Tazmania"]

domains = Hash.new
variables.each do |variable|
    domains[variable] = ["red", "green", "blue"]
end

csp = Csp.new(variables, domains)
csp.add_constraint(MapColoringConstraint.new("Western Australia", "Northern Territory"))
csp.add_constraint(MapColoringConstraint.new("Western Australia", "South Australia"))
csp.add_constraint(MapColoringConstraint.new("South Australia","Northern Territory"))
csp.add_constraint(MapColoringConstraint.new("Queensland", "Northern Territory"))
csp.add_constraint(MapColoringConstraint.new("Queensland", "South Australia"))
csp.add_constraint(MapColoringConstraint.new("Queensland", "New South Wales"))
csp.add_constraint(MapColoringConstraint.new("New South Wales", "South Australia"))
csp.add_constraint(MapColoringConstraint.new("Victoria", "South Australia"))
csp.add_constraint(MapColoringConstraint.new("Victoria", "New South Wales"))
csp.add_constraint(MapColoringConstraint.new("Victoria", "Tazmania"))

solution = csp.backtracking_search()
if solution.nil?
    puts "no solution found"
else
    puts solution
end