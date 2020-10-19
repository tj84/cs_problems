require_relative 'chromosome'

class GeneticAlgorithm
    def initialize(initial_population, threshold, max_generations = 100,
    mutation_chance = 0.01, crossover_chance = 0.7, 
    selection_type = "TOURNAMENT")

    @population = initial_population
    @threshold = threshold
    @max_generations = max_generations
    @mutation_chance = mutation_chance
    @crossover_chance = crossover_chance
    @selection_type = selection_type
    end

    def pick_roulette(wheel)
        # turn weights into percentages
        sum_of_weights = wheel.sum
        percentage_weights = []
        wheel.each do |value|
          percentage_weights << value / sum_of_weights.to_f
        end
        # pick 2 elements
        selection = []
        2.times do
            pick = rand
            index = 0
            while pick > 0
                pick -= percentage_weights[index]
                index += 1
            end
            selection << (index - 1)
        end
        [@population[selection[0]], @population[selection[1]]]
    end

    def pick_tournament(num_participants)
        participants = @population.sample(num_participants)
        participants.sort!.take(2)
    end

    def reproduce_and_replace
        new_population = []
        while new_population.length < @population.length
            if @selection_type == "ROULETTE"
                fitness_weights = []
                @population.each do |x|
                   fitness_weights << x.fitness
                end
                parents = pick_roulette(fitness_weights)
            else
                parents = pick_tournament((@population.length / 2))
            end
            # potentially crossover the 2 parents
            if rand < @crossover_chance
                new_population << parents[0].crossover(parents[1])
            else
                new_population << parents
            end
            new_population.flatten!
        end
        # if odd number we will have 1 extra so need to remove it
        if new_population.length > @population.length
            new_population.pop
        end
        @population = new_population
    end

    def mutate
        @population.each do |individual|
            if rand < @mutation_chance
                individual.mutate
            end
        end
    end

    def run
        best = @population.max {|a, b| a.fitness <=> b.fitness}
        best = best.deep_copy
        @max_generations.times do |i|
            if best.fitness >= @threshold
                return best
            end
            fitness_sum = 0
            @population.each do |individual|
                fitness_sum += individual.fitness
            end
            puts "Generation #{i}, best: #{best.fitness}, average: #{fitness_sum / @population.length}"
            reproduce_and_replace
            mutate
            highest = @population.max {|a, b| a.fitness <=> b.fitness}
            if highest.fitness > best.fitness
                best = highest.deep_copy
            end
        end
        best
    end
end