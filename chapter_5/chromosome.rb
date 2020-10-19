class Chromosome
    include Comparable
    def initialize

    end

    def fitness
        raise "Fitness - must be overridden"
    end

    def random_instance
        raise "Random Instance must be overridden"
    end

    def crossover(other)
        raise "Crossover must be overridden"
    end

    def mutate
        raise "Mutate must be overridden"
    end

    def deep_copy
        raise "Deep copy must be overridden"
    end

    def <=>(other)
        other.fitness <=> self.fitness
    end
end
