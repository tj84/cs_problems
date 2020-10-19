require_relative 'neuron.rb'
require_relative 'util.rb'

class Layer
  attr_accessor :neurons
  attr_accessor :previous_layer
  attr_accessor :output_cache
  def initialize(num_neurons, learning_rate, previous_layer = nil)
    @previous_layer = previous_layer
    @neurons = []
    num_neurons.times do 
      if previous_layer == nil
        random_weights = []
      else
        random_weights = Array.new(@previous_layer.neurons.length) {rand()}
      end
      neuron = Neuron.new(random_weights, learning_rate)
      @neurons.append(neuron)
    end
    @output_cache = Array.new(num_neurons, 0.0)
  end
  
  def outputs(inputs)
    @output_cache = []
    if @previous_layer == nil
      @output_cache = inputs
    else
      @neurons.each do |neuron|
        @output_cache << neuron.output(inputs)
      end 
    end
    @output_cache
  end

  def calculate_deltas_for_output_layer(expected)
    @neurons.length.times do |neuron|
      delta = @neurons[neuron].derivative_activation_function(@neurons[neuron].output_cache) * (expected[neuron] - @output_cache[neuron])
      @neurons[neuron].delta = delta
    end
  end

def calculate_deltas_for_hidden_layer(next_layer)
    @neurons.each_with_index do |neuron, index|
     next_weights = []
     next_layer.neurons.each do |n|
       next_weights << n.weights[index]
     end 
     next_deltas = []
     next_layer.neurons.each do |n|
      next_deltas << n.delta
     end
     sum_weights_and_deltas = dot_product(next_weights, next_deltas)
     neuron.delta = neuron.derivative_activation_function(neuron.output_cache) * sum_weights_and_deltas
    end
  end
end
