
def solve(start, last, temp, n)
  if n == 1
    last.push(start.pop())
  else
    solve(start, temp, last, n - 1)
    solve(start, last, temp, 1)
    solve(temp, last, start, n - 1)
  end
end

tower_a = []
tower_b = []
tower_c = []
discs = 3
discs.times do |i|
  tower_a << i
end

puts "tower a: #{tower_a}"
puts "tower b: #{tower_b}"
puts "tower c: #{tower_c}"

solve(tower_a, tower_c, tower_b, discs)

puts "tower a: #{tower_a}"
puts "tower b: #{tower_b}"
puts "tower c: #{tower_c}"
