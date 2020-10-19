require 'pqueue'
require_relative 'weighted_graph'
require_relative 'weighted_edge'

class DijkstraNode
    include Comparable
    attr_reader :vertex
    attr_reader :distance
    def initialize(vertex, distance)
        @vertex = vertex
        @distance = distance
    end

    def <=>(other)
        @distance <=> other.distance
    end
end

class Dijkstra
    attr_reader :distances
    attr_reader :path_hash
    def initialize(weighted_graph, root)
        @weighted_graph = weighted_graph
        @root = root
        @first = weighted_graph.index_of(root)
        @distances = Array.new(weighted_graph.vertex_count, nil)
        @distances[@first] = 0
        @path_hash = Hash.new
        @pqueue = PQueue.new
        @pqueue.push(DijkstraNode.new(@first, 0))
        solve
    end

    def solve
        while !@pqueue.empty?
            from = @pqueue.shift.vertex
            distance_from = @distances[from]
            @weighted_graph.edges_for_index(from).each do |edge|
                distance_to = @distances[edge.to]
                if distance_to.nil? || distance_to > edge.weight + distance_from.to_i
                    @distances[edge.to] = edge.weight + distance_from.to_i
                    @path_hash[edge.to] = edge
                    @pqueue.push(DijkstraNode.new(edge.to, edge.weight + distance_to.to_i))
                end
            end
        end
    end

    def distance_array_to_vertex
        distance_dict = {}
        @distances.length.times do |i|
            distance_dict[@weighted_graph.vertex_at(i)] = @distances[i]
        end
        distance_dict
    end

    def path_dict_to_path(start, end_path)
        if @path_hash.length == 0
            return []
        end
        edge_path = []
        edge = @path_hash[end_path]
        edge_path.append(edge)
        while edge.from != start
            edge = @path_hash[edge.from]
            edge_path.append(edge)
        end
        edge_path.reverse!
    end
end

city_graph2 = WeightedGraph.new(["Seattle", "San Francisco", "Los Angeles", "Riverside",
    "Phoenix", "Chicago", "Boston", "New York", "Detroit", "Philadelphia", "Atlanta",
     "Miami", "Dallas", "Houston", "Washington"])

city_graph2.add_edge_by_vertices("Seattle", "Chicago", 1737)
city_graph2.add_edge_by_vertices("Seattle", "San Francisco", 678)
city_graph2.add_edge_by_vertices("San Francisco", "Riverside", 386)
city_graph2.add_edge_by_vertices("San Francisco", "Los Angeles", 348)
city_graph2.add_edge_by_vertices("Los Angeles", "Riverside", 50)
city_graph2.add_edge_by_vertices("Los Angeles", "Phoenix", 357)
city_graph2.add_edge_by_vertices("Riverside", "Phoenix", 307)
city_graph2.add_edge_by_vertices("Riverside", "Chicago", 1704)
city_graph2.add_edge_by_vertices("Phoenix", "Dallas", 887)
city_graph2.add_edge_by_vertices("Phoenix", "Houston", 1015)
city_graph2.add_edge_by_vertices("Dallas", "Chicago", 805)
city_graph2.add_edge_by_vertices("Dallas", "Atlanta", 721)
city_graph2.add_edge_by_vertices("Dallas", "Houston", 225)
city_graph2.add_edge_by_vertices("Houston", "Atlanta", 702)
city_graph2.add_edge_by_vertices("Houston", "Miami", 968)
city_graph2.add_edge_by_vertices("Atlanta", "Chicago", 588)
city_graph2.add_edge_by_vertices("Atlanta", "Washington", 543)
city_graph2.add_edge_by_vertices("Atlanta", "Miami", 604)
city_graph2.add_edge_by_vertices("Miami", "Washington", 923)
city_graph2.add_edge_by_vertices("Chicago", "Detroit", 238)
city_graph2.add_edge_by_vertices("Detroit", "Boston", 613)
city_graph2.add_edge_by_vertices("Detroit", "Washington", 396)
city_graph2.add_edge_by_vertices("Detroit", "New York", 482)
city_graph2.add_edge_by_vertices("Boston", "New York", 190)
city_graph2.add_edge_by_vertices("New York", "Philadelphia", 81)
city_graph2.add_edge_by_vertices("Philadelphia", "Washington", 123)

puts city_graph2

solution = Dijkstra.new(city_graph2, "Los Angeles")
name_distances = solution.distance_array_to_vertex
puts "Distances from Los Angeles:"
name_distances.each_pair do |key, value|
    puts "#{key}: #{value}"
end
puts "----"
puts "Shortest path from Los Angeles to Boston:"
weighted_path = solution.path_dict_to_path(city_graph2.index_of("Los Angeles"),
city_graph2.index_of("Boston"))
weighted_path.each do |edge|
    puts "#{city_graph2.vertex_at(edge.from)} #{edge.weight} >\
 #{city_graph2.vertex_at(edge.to)}"
end
