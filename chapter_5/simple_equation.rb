require_relative 'chromosome'
require_relative 'genetic_algorithm'

class SimpleEquation < Chromosome
    attr_accessor :x
    attr_accessor :y
    def initialize(x, y)
        @x = x
        @y = y
        @fitness = fitness
    end

    def fitness
        6 * @x - @x**2 + 4 * @y - @y**2
    end

    def crossover(other)
        child_a = self.clone
        child_b = other.clone
        child_a.y, child_b.y = child_b.y, child_a.y
        [child_a, child_b]
    end

    def mutate
        if rand > 0.5
            if rand > 0.5
                @x += 1
            else
                @x -= 1
            end
        else
            if rand > 0.5
                @y += 1
            else
                @y -= 1
            end
        end
    end

    def deep_copy
        SimpleEquation.new(self.x.clone, self.y.clone)
    end

    def to_s
        "x: #{@x} y: #{@y}, fitness: #{self.fitness}"
    end
end

initial_population = []
20.times do
    initial_population << SimpleEquation.new(rand(0..100), rand(0..100))
end

genetic_algorithm = GeneticAlgorithm.new(initial_population,
threshold = 13.0, max_generations = 100, mutation_chance = 0.1,
crossover_chance = 0.7)

result = genetic_algorithm.run
puts result