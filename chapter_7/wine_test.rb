require 'csv'
require_relative 'util.rb'
require_relative 'network.rb'
wine_parameters = []
wine_classifications = []
wine_species = []
wines = CSV.read("wine.csv", converters: :numeric)
wines.shuffle!
wines.each do |wine|
  parameters = wine[1..14]
  wine_parameters.append(parameters)
  species = wine[0] 
  if species == 1
    wine_classifications.append([1.0, 0.0, 0.0])
  elsif species == 2
    wine_classifications.append([0.0, 1.0, 0.0])
  else
    wine_classifications.append([0.0, 0.0, 1.0])
  end
  wine_species.append(species)
end
normalize_by_feature_scaling(wine_parameters)

wine_network = Network.new([13, 7, 3], 0.9)

class Neuron
  def activation_function(elements)
    sigmoid(elements)
  end

  def derivative_activation_function(elements_a)
    sig = activation_function(elements_a)
    return sig * (1 - sig)
  end
end

class Network
  def interpret_output(output)
    if output.max == output[0]
      return 1
    elsif output.max == output[1]
      return 2
    else
      return 3
    end
  end
end

wine_trainers = wine_parameters[0...150]
wine_trainers_corrects = wine_classifications[0...150]
10.times do
  wine_network.train(wine_trainers, wine_trainers_corrects)
end

wine_testers = wine_parameters[150..178]
wine_testers_corrects = wine_species[150..178]
wine_results = wine_network.validate(wine_testers, wine_testers_corrects)
puts "#{wine_results[0]} correct of #{wine_results[1]} = #{wine_results[2]}%"
