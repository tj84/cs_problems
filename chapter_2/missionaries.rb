require_relative 'search.rb'

MAX_NUM = 3

class State
    attr_reader :west_missionairies
    attr_reader :west_cannibals
    attr_reader :east_missionairies
    attr_reader :east_cannibals
    attr_reader :boat
    def initialize(missionairies, cannibals, boat)
        @west_missionairies = missionairies
        @west_cannibals = cannibals
        @east_missionairies = MAX_NUM - @west_missionairies
        @east_cannibals = MAX_NUM - @west_cannibals
        @boat = boat
    end

    def to_s
        "wm: #{@west_missionairies}, wc: #{@west_cannibals}, em: #{@east_missionairies}, ec: #{@east_cannibals}, boat: #{@boat}"
    end

    def is_valid?
        if @west_missionairies < @west_cannibals && @west_missionairies > 0
            return false
        end
        if @east_missionairies < @east_cannibals && @east_missionairies > 0
            return false
        end
        true
    end

    def eql?(x)
        @west_missionairies == x.west_missionairies && 
        @west_cannibals == x.west_cannibals &&
        @east_missionairies == x.east_missionairies &&
        @east_cannibals == x.east_cannibals &&
        @boat == x.boat
    end

    def ==(x)
        @west_missionairies == x.west_missionairies && 
        @west_cannibals == x.west_cannibals &&
        @east_missionairies == x.east_missionairies &&
        @east_cannibals == x.east_cannibals &&
        @boat == x.boat
    end
 
    # needed for set include? method
    def hash
        1
    end
end

class Bank
    attr_reader :start
    attr_reader :state
    def initialize(missionairies, cannibals, boat)
        @state = State.new(missionairies, cannibals, boat)
        @start = @state
    end

    def to_s
        "On the west bank there are #{@state.west_missionairies} missionairies and #{@state.west_cannibals} cannibals
On the east bank there are #{@state.east_missionairies} missionairies and #{@state.east_cannibals} cannibals
The boat is on the #{@state.boat ? "west" : "east"}."
    end

    def goal_test(state)
        state.is_valid? && 
        state.east_missionairies == MAX_NUM && 
        state.east_cannibals == MAX_NUM
    end

    def successors(state)
        moves = []
        if state.boat
            if state.west_missionairies > 1
                moves << State.new(state.west_missionairies - 2, state.west_cannibals, !state.boat)
            end
            if state.west_missionairies > 0
                moves << State.new(state.west_missionairies - 1, state.west_cannibals, !state.boat)
            end
            if state.west_cannibals > 1
                moves << State.new(state.west_missionairies, state.west_cannibals - 2, !state.boat)
            end
            if state.west_cannibals > 0
                moves << State.new(state.west_missionairies, state.west_cannibals - 1, !state.boat)
            end
            if state.west_missionairies > 0 && state.west_cannibals > 0
                moves << State.new(state.west_missionairies - 1, state.west_cannibals - 1, !state.boat)
            end
        else
            if state.east_missionairies > 1
                moves << State.new(state.west_missionairies + 2, state.west_cannibals, !state.boat)
            end
            if state.east_missionairies > 0
                moves << State.new(state.west_missionairies + 1, state.west_cannibals, !state.boat)
            end
            if state.east_cannibals > 1
                moves << State.new(state.west_missionairies, state.west_cannibals + 2, !state.boat)
            end
            if state.east_cannibals > 0
                moves << State.new(state.west_missionairies, state.west_cannibals + 1, !state.boat)
            end
            if state.east_cannibals > 0 && state.east_missionairies > 0
                moves << State.new(state.west_missionairies + 1, state.west_cannibals + 1, !state.boat)
            end
        end
        moves.delete_if {|move| !move.is_valid?}
    end

    def display_solution(path)
        return if path.length == 0
        old_state  = path[0]
        puts old_state
        path.each do |current_state|
            if current_state.boat
                puts "#{old_state.east_missionairies - current_state.east_missionairies} missionaries and #{old_state.east_cannibals - current_state.east_cannibals} cannibals moved from the east bank to the west bank"
            else
                puts "#{old_state.west_missionairies - current_state.west_missionairies} missionaries and #{old_state.west_cannibals - current_state.west_cannibals} cannibals moved from the west bank to the east bank"
            end
            puts current_state
            old_state = current_state
        end

    end
end

start = Bank.new(MAX_NUM, MAX_NUM, true)
solution = BFS.new(start)
unless solution.solution_found
    puts "No solution found using BFS serch!"
else
    puts "Solution found - BFS"
    puts start
    start.display_solution(solution.solution_path)
end
