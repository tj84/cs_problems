def calculate_pi(terms)
  numerator = 4.0
  denominator = 1.0
  operation = 1.0
  pi = 0.0
  (0..terms).each do
    pi += operation * (numerator / denominator)
    operation *= -1
    denominator += 2
  end
  return pi
end

puts calculate_pi(1000000)
