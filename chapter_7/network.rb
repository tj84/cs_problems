require_relative 'layer.rb'
require_relative 'util.rb'

class Network
  def initialize(layer_structure, learning_rate)
    if layer_structure.length < 3
      raise "Error shoud be at least 3 layers (1 input, 1 hidden, 1 ouput)"
    end
    @layers = []
    #input layer
    input_layer = Layer.new(layer_structure[0], learning_rate, nil)
    @layers.append(input_layer)
    # hidden layers and output layer
    layer_structure[1..].each_with_index do |num_neurons, previous|
      next_layer = Layer.new(num_neurons, learning_rate, @layers[previous])
      @layers.append(next_layer)
    end
  end

  def outputs(input)
    reduce_layers(input)
  end
 
  def reduce_layers(input)
    value = input
    @layers.each do |layer|
      value = layer.outputs(value)
    end
    value
  end

  def backpropagate(expected)
    last_layer = @layers.length - 1
    @layers[last_layer].calculate_deltas_for_output_layer(expected)
    index_array = *(0..last_layer - 1)
    index_array = index_array.reverse
    index_array.each do |index|
      @layers[index].calculate_deltas_for_hidden_layer(@layers[index + 1])
    end
  end

  def update_weights
    @layers[1..].each do |layer|
      layer.neurons.each do |neuron|
        neuron.weights.length.times do |i|
          neuron.weights[i] = neuron.weights[i] + (neuron.learning_rate * (layer.previous_layer.output_cache[i]) * neuron.delta)
        end
      end
    end
  end

  def train(inputs, expecteds)
    inputs.each_with_index do |xs, location|
      ys = expecteds[location]
      out = outputs(xs)
      backpropagate(ys)
      update_weights()
    end
  end

  def validate(inputs, expecteds)
    correct = 0
    inputs.zip(expecteds).each do |arr|
      input = arr[0]
      expected = arr[1]
      result = interpret_output(outputs(input))
      if result == expected
        correct += 1
      end
    end
    percentage = (correct.to_f / inputs.length.to_f) * 100.0
    return correct, inputs.length, percentage
  end

  def interpret_output(outputs)
    raise "must overload the interpret_output function"
  end
end
