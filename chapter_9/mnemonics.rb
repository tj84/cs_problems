def possible_mnemonics(phone_number)
  phone_mapping = {1 => [1],
                 2 =>['a', 'b', 'c'],
                 3 =>['d', 'e', 'f'],
                 4 =>['g', 'h', 'i'],
                 5 =>['j', 'k', 'l'],
                 6 =>['m', 'n', 'o'],
                 7 =>['p', 'q', 'r', 's'],
                 8 =>['t', 'u', 'v'],
                 9 =>['w', 'x', 'y', 'z'],
                 0 =>[0]}

  phone_number.strip!
  letters = []
  phone_number.each_char do |digit|
    letters.append(phone_mapping[digit.to_i])
  end
  [''].product.product(*letters) 
end

puts "Enter a phone number:"
phone_number = gets
puts "Here are the mnemonics:"
mnemonics = possible_mnemonics(phone_number)
mnemonics.each do |mnemonic|
  puts "#{mnemonic[1..].join},"
end

File.open("test.csv", "w") do |f|
  mnemonics.each do |mnemonic|
    f.write "#{mnemonic[1..].join},\n"
  end
end
