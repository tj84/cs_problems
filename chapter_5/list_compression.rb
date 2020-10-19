require_relative 'chromosome'
require_relative 'genetic_algorithm'
require 'zlib'

PEOPLE = ["Michael", "Sarah", "Joshua", "Narine", "David", "Sajid",
"Melanie", "Daniel", "Wei", "Dean", "Brian", "Murat", "Lisa"]

class ListCompression < Chromosome
    attr_accessor :list
    def initialize(list)
        @list = list
        @fitness = fitness
    end

    def bytes_compressed
        Zlib::Deflate.deflate(@list.to_s)
    end

    def fitness
        1.0 / bytes_compressed.size
    end

    def crossover(other)
        child_a = self.deep_copy
        child_b = other.deep_copy
        indices = *(0...@list.length)
        indices_sample = indices.sample(2)
        index_1 = indices_sample[0]
        index_2 = indices_sample[1]
        person_1 = child_a.list[index_1]
        person_2 = child_b.list[index_2]
        child_a.list[child_a.list.index(person_2)], 
            child_a.list[index_2] = child_a.list[index_2], person_2
        child_b.list[child_b.list.index(person_1)],
            child_b.list[index_1] = child_b.list[index_1], person_1
        [child_a, child_b]
    end

    def mutate
        indices = *(0...@list.length)
        indices_sample = indices.sample(2)
        index_1 = indices_sample[0]
        index_2 = indices_sample[1]
        @list[index_1], @list[index_2] = @list[index_2], @list[index_1]
    end

    def deep_copy
        ListCompression.new(self.list.clone)
    end

    def to_s
        "list order: #{@list}, bytes: #{bytes_compressed}"
    end
end

puts "starting list is #{PEOPLE}, and takes up #{PEOPLE.to_s.size} bytes"

inital_population = []
1000.times do
    inital_population << ListCompression.new(PEOPLE.clone.shuffle)
end

genetic_algorithm = GeneticAlgorithm.new(inital_population, threshold = 1.0,
max_generations = 1000, mutation_chance = 0.2, crossover_chance = 0.7)
result = genetic_algorithm.run
puts result