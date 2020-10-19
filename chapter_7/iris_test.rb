require 'csv'
require_relative "util.rb"
require_relative "network.rb"
iris_parameters = []
iris_classifications = []
iris_species = []
irises = CSV.read("iris.csv", converters: :numeric)
irises.shuffle!
irises.each do |iris|
  parameters = iris[0...4]
  iris_parameters.append(parameters)
  species = iris[4]
  if species == "Iris-setosa"
    iris_classifications.append([1.0, 0.0, 0.0])
  elsif species == "Iris-versicolor"
    iris_classifications.append([0.0, 1.0, 0.0])
  else
    iris_classifications.append([0.0, 0.0, 1.0])
  end
  iris_species.append(species)
end
normalize_by_feature_scaling(iris_parameters)

iris_network = Network.new([4, 6, 3], 0.3) 

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
      return "Iris-setosa"
    elsif output.max == output[1]
      return "Iris-versicolor"
    else
      return "Iris-virginica"
    end
  end
end

iris_trainers = iris_parameters[0...140]
iris_trainers_corrects = iris_classifications[0...140]
50.times do
  iris_network.train(iris_trainers, iris_trainers_corrects)
end
iris_testers = iris_parameters[140..150]
iris_testers_corrects = iris_species[140..150]
iris_results = iris_network.validate(iris_testers, iris_testers_corrects)
puts "#{iris_results[0]} correct of #{iris_results[1]} = #{iris_results[2]}%"
