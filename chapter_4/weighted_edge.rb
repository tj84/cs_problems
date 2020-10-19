require_relative 'edge'

class WeightedEdge < Edge
    include Comparable
    attr_reader :from
    attr_reader :to
    attr_reader :weight
    def initialize(to, from, weight)
        @to = to # v
        @from = from # u
        @weight = weight
    end

    def <=>(other)
        @weight <=> other.weight
    end

    def to_s
        puts "from: #{@from} #{@weight} -> to: #{@to}"
    end
end