require_relative 'edge'
require_relative '../chapter_2/search'

class Graph
    def initialize(vertices)
        @vertices = vertices
        @edges = []
        @vertices.each do 
            @edges << []
        end
    end

    def vertex_count
        @vertices.length
    end

    def edge_count
        edges = 0
        @edges.each do |edge|
            edges += edge.length
        end
        edges
    end

    def add_vertex(vertex)
        @vertices.append(vertex)
        @edges.append([])
        vertext_count - 1
    end

    def add_edge(edge)
        @edges[edge.from].append(edge)  # u
        other_edge = edge.clone
        other_edge.reversed
        @edges[edge.to].append(other_edge)    # v
    end

    def add_edge_by_indices(from, to)
        edge = Edge.new(to, from)
        add_edge(edge)
    end

    def add_edge_by_vertices(first, second)
        from = @vertices.index(first)
        to = @vertices.index(second)
        add_edge_by_indices(from, to)
    end

    def vertex_at(index)
        @vertices[index]
    end

    def index_of(vertex)
        @vertices.index(vertex)
    end

    def neighbours_for_index(index)
        list = []
        @edges[index].each do |e|
            list << vertex_at(e.to)
        end
        list
    end

    def neighbours_for_vertex(vertex)
        neighbours_for_index(index_of(vertex))
    end

    def edges_for_index(index)
        @edges[index]
    end

    def edges_for_vertex(vertex)
        edges_for_index(index_of(vertex))
    end

    def to_s
        desc = ""
        vertex_count.times do |i|
            desc += "#{vertex_at(i)} -> #{neighbours_for_index(i)}\n"
        end
        desc
    end
end

city_graph = Graph.new(["Seattle", "San Francisco", "Los Angeles", "Riverside",
    "Phoenix", "Chicago", "Boston", "New York", "Detroit", "Philadelphia", "Atlanta",
     "Miami", "Dallas", "Houston", "Washington"])

city_graph.add_edge_by_vertices("Seattle", "Chicago")
city_graph.add_edge_by_vertices("Seattle", "San Francisco")
city_graph.add_edge_by_vertices("San Francisco", "Riverside")
city_graph.add_edge_by_vertices("San Francisco", "Los Angeles")
city_graph.add_edge_by_vertices("Los Angeles", "Riverside")
city_graph.add_edge_by_vertices("Los Angeles", "Phoenix")
city_graph.add_edge_by_vertices("Riverside", "Phoenix")
city_graph.add_edge_by_vertices("Riverside", "Chicago")
city_graph.add_edge_by_vertices("Phoenix", "Dallas")
city_graph.add_edge_by_vertices("Phoenix", "Houston")
city_graph.add_edge_by_vertices("Dallas", "Chicago")
city_graph.add_edge_by_vertices("Dallas", "Atlanta")
city_graph.add_edge_by_vertices("Dallas", "Houston")
city_graph.add_edge_by_vertices("Houston", "Atlanta")
city_graph.add_edge_by_vertices("Houston", "Miami")
city_graph.add_edge_by_vertices("Atlanta", "Chicago")
city_graph.add_edge_by_vertices("Atlanta", "Washington")
city_graph.add_edge_by_vertices("Atlanta", "Miami")
city_graph.add_edge_by_vertices("Miami", "Washington")
city_graph.add_edge_by_vertices("Chicago", "Detroit")
city_graph.add_edge_by_vertices("Detroit", "Boston")
city_graph.add_edge_by_vertices("Detroit", "Washington")
city_graph.add_edge_by_vertices("Detroit", "New York")
city_graph.add_edge_by_vertices("Boston", "New York")
city_graph.add_edge_by_vertices("New York", "Philadelphia")
city_graph.add_edge_by_vertices("Philadelphia", "Washington")
puts city_graph

class RouteFinder
    attr_reader :start
    def initialize(start, goal, graph)
        @start = start
        @goal = goal
        @graph = graph
    end

    def goal_test(current_location)
        current_location == @goal
    end

    def successors(current_location)
        possible_moves = @graph.neighbours_for_vertex(current_location)
    end
end

route_to_find = RouteFinder.new("Boston", "Miami", city_graph)
solution = BFS.new(route_to_find)
unless solution.solution_found
    puts "No solution found using breadth first search"
else
    puts "Solution found!"
    path = solution.solution_path
    puts "Path from Boston to Miami: "
    puts path
end










