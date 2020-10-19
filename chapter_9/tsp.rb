vt_distances = {
  "Rutland" => {"Burlington" =>67,
                "White River Junction" => 46,
                "Bennington" => 55,
                "Brattleboro" => 75},
  "Burlington" => {"Rutland" => 67,
                   "White River Junction" => 91,
                   "Bennington" => 122,
                   "Brattleboro" => 153},
  "White River Junction" => {"Rutland" => 46,
                             "Burlington" => 91,
                             "Bennington" => 98,
                             "Brattleboro" =>65},
  "Bennington" => {"Rutland" => 55,
                   "Burlington" => 122,
                   "White River Junction" => 98,
                   "Brattleboro" => 40},
  "Brattleboro" => {"Rutland" => 75,
                    "Burlington" =>153,
                    "White River Junction" => 65,
                    "Bennington" => 40}
}

vt_cities = vt_distances.keys
city_permutations = vt_cities.permutation
tsp_paths = []
city_permutations.each do |tour|
  tour.append(tour[0])
  tsp_paths << tour
end
best_path = {}
min_distance = Float::INFINITY
tsp_paths.each do |tour|
  distance = 0
  last = tour[0]
  tour[1..].each do |next_city|
    distance += vt_distances[last][next_city]
    last = next_city
  end
  if distance < min_distance
    min_distance = distance
    best_path = tour
  end
end
puts "The shortest path is #{best_path}, in #{min_distance} miles."
