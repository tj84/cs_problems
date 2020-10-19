class Edge
    attr_reader :from
    attr_reader :to
    def initialize(to, from)
        @to = to # v
        @from = from # u
    end

    def reversed
        @to, @from = @from, @to
    end

    def to_s
        puts "from: #{@from} -> to: #{@to}"
    end

end