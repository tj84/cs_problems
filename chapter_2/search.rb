require 'set'
require 'pqueue'

class Node
    include Comparable
    attr_reader :state
    attr_reader :parent
    attr_reader :cost
    attr_reader :heuristic
    def initialize(state, parent = nil, cost = 0.0, heuristic = 0.0)
        @state = state
        @parent = parent
        @cost = cost
        @heuristic = heuristic
    end

    def <(other)
        (@cost + @heuristic) < (other.cost + other.heuristic)
    end

    def <=>(other)
        (@cost + @heuristic) <=> (other.cost + other.heuristic)
    end
    
    def to_s
        "state: #{@state}, parent: #{@parent.class}, cost: #{@cost}, heuristic: #{@heuristic}"
    end
end

class DFS
    attr_reader :solution_found
    attr_reader :solution_path
    attr_reader :iterations
    def initialize(maze)
        # the object being searched
        @maze = maze
        # frontier to where we've yet to go
        @frontier = []
        @frontier.push(Node.new(@maze.start))
        @solution_found = false
        @solution_path = []
        # explored is where we have been
        @explored = Set.new
        @iterations = 0
        search
    end

    def node_to_path(node)
        path = []
        path << node.state
        until node.parent.nil?
            node = node.parent
            path.append(node.state)
        end
        path.reverse
    end

    private

    def search
        while ! @frontier.empty?
            @iterations += 1
            current_node = @frontier.pop
            current_state = current_node.state
            #goal check
            if @maze.goal_test(current_state)
                @solution_found = true
                @solution_path = node_to_path(current_node)
                return
            end
            @maze.successors(current_state).each do |child|
                if @explored.include?(child) 
                    next
                end
                @explored << child
                @frontier.push(Node.new(child, current_node))
            end
        end
    end
end


class BFS
    attr_reader :solution_found
    attr_reader :solution_path
    attr_reader :iterations
    def initialize(maze)
        # the object being searched
        @maze = maze
        # frontier to where we've yet to go
        @frontier = []
        @frontier.push(Node.new(@maze.start))
        @solution_found = false
        @solution_path = []
        # explored is where we have been
        @explored = Set.new
        @iterations = 0
        search
    end

    def node_to_path(node)
        path = []
        path << node.state
        while !node.parent.nil?
            node = node.parent
            path.append(node.state)
        end
        path.reverse
    end

    private

    def search
        while ! @frontier.empty?
            @iterations += 1
            current_node = @frontier.shift
            current_state = current_node.state
            #goal check
            if @maze.goal_test(current_state)
                @solution_found = true
                @solution_path = node_to_path(current_node)
                return
            end
            @maze.successors(current_state).each do |child|
                if @explored.include?(child)
                    next
                end
                @explored << child
                @frontier.append(Node.new(child, current_node))
            end
        end
    end
end

class Astar
    attr_reader :solution_found
    attr_reader :solution_path
    attr_reader :iterations
    def initialize(maze)
        # the object being searched
        @maze = maze
        # frontier to where we've yet to go
        @frontier = PQueue.new()
        @frontier << Node.new(@maze.start, nil, 0.0, @maze.manhattan_distance(@maze.start))
        @solution_found = false
        @solution_path = []
        # explored is where we have been
        @explored = Hash.new()
        @explored[maze.start] = 0.0
        @iterations = 0
        search
    end

    def node_to_path(node)
        path = []
        path << node.state
        while not node.parent.nil?
            node = node.parent
            path.append(node.state)
        end
        path.reverse
    end

    private

    def search
        while !@frontier.empty?
            @iterations += 1
            current_node = @frontier.shift
            current_state = current_node.state
            #goal check
            if @maze.goal_test(current_state)
                @solution_found = true
                @solution_path = node_to_path(current_node)
                return
            end
            @maze.successors(current_state).each do |child|
                new_cost = current_node.cost + 1
                if !(@explored.has_key?(child)) || @explored[child] > new_cost
                    @explored[child] = new_cost
                    @frontier.push(Node.new(child, current_node, new_cost, @maze.manhattan_distance(child)))
                end
            end
        end
    end  
end