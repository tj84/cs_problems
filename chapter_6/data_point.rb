class DataPoint
    attr_accessor :dimensions
    def initialize(initials)
        @originals = initials
        @dimensions = initials
    end

    def num_dimensions
        @dimensions.size
    end

    def distance(other)
        combined = @dimensions.zip(other.dimensions)
        differences = []
        combined.each do |elements|
            differences << (elements[0] - elements[1]) ** 2
        end
        sum_diff = differences.inject(0.0) {|sum, elem| sum + elem}
        Math.sqrt(sum_diff)
    end

    def ==(other)
        @dimensions == other.dimensions
    end
end


