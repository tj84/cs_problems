require 'pqueue'
require_relative 'weighted_graph'
require_relative 'weighted_edge'

class MST
    attr_reader :result
    def initialize(weighted_graph, start = 0)
        @weighted_graph = weighted_graph
        @result = []
        @pqueue = PQueue.new
        @visited = Array.new(weighted_graph.vertex_count, false)
        mst(start)
    end

    def mst(start)
        if start > @weighted_graph.vertex_count - 1 || start < 0
            return nil
        end

        visit(start)
        while !@pqueue.empty?
            edge = @pqueue.shift
            if @visited[edge.to]
                next
            end
            @result.append(edge)
            visit(edge.to)
        end
    end

    def visit(index)
        @visited[index] = true
        @weighted_graph.edges_for_index(index).each do |edge|
            if !@visited[edge.to]
                @pqueue << edge
            end
        end
    end
end

def total_weight(weighted_path)
    sum = 0
    weighted_path.result.each do |path|
        sum += path.weight
    end
    sum
end

def printed_weighted_path(weighted_graph, weighted_path)
    puts "-----------"
    weighted_path.result.each do |edge|
        puts "#{weighted_graph.vertex_at(edge.from)} #{edge.weight} > #{weighted_graph.vertex_at(edge.to)}"
    end
    puts " total weight: #{total_weight(weighted_path)}"
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

result = MST.new(city_graph2)

if result.nil?
    puts "No solution found"
else
    printed_weighted_path(city_graph2, result)
end