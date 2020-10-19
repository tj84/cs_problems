
def classic_hanoi(start, last, temp, discs)
  if discs == 1
    last.push(start.pop())
  else
    classic_hanoi(start, temp, last, discs - 1)
    classic_hanoi(start, last, temp, 1)
    classic_hanoi(temp, last, start, discs - 1)
  end
end

def solve(towers, discs)
  if towers.length == 3
    classic_hanoi(towers[0], towers[1], towers[2], discs)
  else
    temp_discs = discs / 2
    temp_towers = [towers[0], towers[1], towers[2]]
    solve(temp_towers, temp_discs)
    temp_towers = [towers[0], towers[3], towers[2]]
    solve(temp_towers, discs - temp_discs)
    temp_towers = [towers[1], towers[3], towers[2]]
    solve(temp_towers, temp_discs)
  end
end

tower_a = []
tower_b = []
tower_c = []
tower_d = []
discs = 15

discs.times do |i|
  tower_a << i
end

towers = []
towers << tower_a
towers << tower_b
towers << tower_c
towers << tower_d

puts "tower a: #{tower_a}"
puts "tower b: #{tower_b}"
puts "tower c: #{tower_c}"
puts "tower d: #{tower_d}"

solve(towers, discs)

puts "tower a: #{tower_a}"
puts "tower b: #{tower_b}"
puts "tower c: #{tower_c}"
puts "tower d: #{tower_d}"
