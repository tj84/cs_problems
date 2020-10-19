require_relative 'csp'

class SendMoreMoneyConstraint
    attr_reader :variables
    def initialize(letters)
        @variables = letters
    end
end

class Csp
    def satisfied?(assignment, constraint)
        if assignment.values.uniq.length < assignment.values.length
            return false
        end

        if assignment.values.length == 8
            s = assignment["S"]
            e = assignment["E"]
            n = assignment["N"]
            d = assignment["D"]
            m = assignment["M"]
            o = assignment["O"]
            r = assignment["R"]
            y = assignment["Y"]
            send = s * 1000 + e * 100 + n * 10 + d
            more = m * 1000 + o * 100 + r * 10 + e
            money = m * 10000 + o * 1000 + n * 100 + e * 10 + y
            return send + more == money
        end
        return true
    end
end

letters = ["S", "E", "N", "D", "M", "O", "R", "Y"]
possible_digits = {}
letters.each do |letter|
    possible_digits[letter] = *(0..9)
end
possible_digits["M"] = [1]
csp = Csp.new(letters, possible_digits)
csp.add_constraint(SendMoreMoneyConstraint.new(letters))
solution = csp.backtracking_search()
if solution.nil?
    puts "No solution"
else
    puts solution
end
