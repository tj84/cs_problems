class Csp
    def initialize(variables, domains)
        @variables = variables
        @domains = domains
        @constraints = Hash.new
        variables.each do |variable|
            @constraints[variable] = []
            if !@domains.has_key? variable
                raise "Error! Every variable should have a domain assigned to it"
            end
        end
    end

    def add_constraint(constraint)
        constraint.variables.each do |variable|
            if !@variables.include? variable
                raise "Error! Variable in constraint not in CSP"
            else
                @constraints[variable] << constraint
            end
        end
    end

    def consistent(variable, assignment)
        @constraints[variable].each do |constraint|
            if !satisfied?(assignment, constraint)
                return false
            end
            true
        end
    end

    def satisfied?(assignment, constraint)
        raise "must be over ridden by the user"
    end

    def backtracking_search(assignment = Hash.new)
        #base case - all variables are assigned
        #puts "var:#{@variables.length}, assign: #{assignment.length}"

        if assignment.length == @variables.length
            return assignment
        end

        unassigned = []
        @variables.each do |variable|
            if !assignment.has_key?(variable)
                unassigned << variable
            end
        end

        first = unassigned[0]

        @domains[first].each do |value|
            local_assignment = assignment.clone
            local_assignment[first] = value
            if consistent(first, local_assignment)
                result = backtracking_search(local_assignment)
                if result != nil
                    return result
                end
            end
        end
        return nil
    end
end