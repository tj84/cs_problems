require_relative 'chromosome'
require_relative 'genetic_algorithm'

class SendMoreMoney < Chromosome
    attr_accessor :letters
    def initialize(letters)
        @letters = letters
        @fitness = fitness
        @object_id = self.object_id
    end

    def fitness
        s = @letters.index("S")
        e = @letters.index("E")
        n = @letters.index("N")
        d = @letters.index("D")
        m = @letters.index("M")
        o = @letters.index("O")
        r = @letters.index("R")
        y = @letters.index("Y")
        send = s * 1000 + e * 100 + n * 10 + d
        more = m * 1000 + o * 100 + r * 10 + e
        money = m * 10000 + o * 1000 + n * 100 + e * 10 + y
        difference = (money - (send + more)).abs
        1 / (difference + 1.0)
    end

    def crossover(other)
        child_a = self.deep_copy
        child_b = other.deep_copy
        indices = *(0...@letters.length)
        indices_sample = indices.sample(2)
        index_1 = indices_sample[0]
        index_2 = indices_sample[1]
        letter_1 = child_a.letters[index_1]
        letter_2 = child_b.letters[index_2]
        child_a.letters[child_a.letters.index(letter_2)], 
            child_a.letters[index_2] = child_a.letters[index_2], letter_2
        child_b.letters[child_b.letters.index(letter_1)],
            child_b.letters[index_1] = child_b.letters[index_1], letter_1
        [child_a, child_b]
    end

    def mutate
        indices = *(0...@letters.length)
        indices_sample = indices.sample(2)
        index_1 = indices_sample[0]
        index_2 = indices_sample[1]
        @letters[index_1], @letters[index_2] = @letters[index_2], @letters[index_1]
    end

    def deep_copy
        SendMoreMoney.new(self.letters.clone)
    end

    def to_s
        s = @letters.index("S")
        e = @letters.index("E")
        n = @letters.index("N")
        d = @letters.index("D")
        m = @letters.index("M")
        o = @letters.index("O")
        r = @letters.index("R")
        y = @letters.index("Y")
        send = s * 1000 + e * 100 + n * 10 + d
        more = m * 1000 + o * 100 + r * 10 + e
        money = m * 10000 + o * 1000 + n * 100 + e * 10 + y
        difference = (money - (send + more)).abs
        "#{send} + #{more} = #{money}. Difference: #{1 / (difference + 1.0)}, #{@letters}} \n"
    end
end

letters = ["S", "E", "N", "D", "M", "O", "R", "Y", "-", "-"]

initial_population = []
1000.times do
    initial_population << SendMoreMoney.new(letters.shuffle)
end

genetic_algorithm = GeneticAlgorithm.new(initial_population,
    threshold = 1.0, max_generations = 1000, mutation_chance = 0.2,
    crossover_chance = 0.7, selection_type = "ROULETTE")
result = genetic_algorithm.run
puts result
