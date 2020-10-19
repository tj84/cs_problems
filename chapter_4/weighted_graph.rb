require_relative 'weighted_edge'
require_relative 'graph'

class WeightedGraph < Graph
    def initialize(vertices)
        @vertices = vertices
        @edges = []
        @vertices.each do 
            @edges << []
        end
    end

    def add_edge_by_indices(from, to, weight)
        edge = WeightedEdge.new(from, to, weight)
        add_edge(edge)
    end

    def add_edge_by_indices(from, to, weight)
        edge = WeightedEdge.new(from, to, weight)
        add_edge(edge)
    end

    def add_edge_by_vertices(first, second, weight)
        from = @vertices.index(first)
        to = @vertices.index(second)
        add_edge_by_indices(from, to, weight)
    end

    def neighbours_for_index_with_weights(index)
        vertices = Hash.new
        edges_for_index(index).each do |edge|
            vertices[vertex_at(edge.to)] = edge.weight
        end
        vertices
    end

    def to_s
        desc = ""
        vertex_count.times do |i|
            desc += "#{vertex_at(i)} -> #{neighbours_for_index_with_weights(i)}\n"
        end
        desc
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