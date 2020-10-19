class Neuron
  attr_accessor :weights
  attr_accessor :learning_rate
  attr_accessor :output_cache
  attr_accessor :delta
  def initialize(weights, learning_rate)
    @weights = weights
    @learning_rate = learning_rate
    @output_cache = 0.0
    @delta = 0.0
  end

  def activation_function(elements)
    raise "Error must be overloaded"
  end

  def derivative_activation_function(elements_a)
    raise "Error must be overloaded"
  end

  def output(inputs)
    @output_cache = dot_product(inputs, @weights)
    activation_function(@output_cache)
  end
end
