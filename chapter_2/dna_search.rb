
gene = "ACGTGGCTCTCTAACGTACGTACGTACGGGGTTTATATATACCCTAGGACTCCCTTT"

def string_to_gene(string)
  gene = []
  string.scan(/.{3}/).each do |codon|
    if codon.length == 3
      gene << codon
    end
  end
end

puts "#{string_to_gene(gene)}"

gene = string_to_gene(gene)

# linear search
def linear_contains(gene, codon_to_match)
  gene.each do |codon|
    if codon == codon_to_match
      return true
    end
  end
  false
end

codon_a = "ACG"
codon_b = "GAT"

puts "#{linear_contains(gene, codon_a)}"
puts "#{linear_contains(gene, codon_b)}"

# ruby include method
puts "#{gene.include?("ACG")}"
puts "#{gene.include?("GAT")}"

# binary search
def binary_contains(gene, codon_to_match)
  low = 0
  high = gene.length - 1
  while low <= high
    mid = (low + high) / 2
    if gene[mid] < codon_to_match
      low = mid + 1
    elsif gene[mid] > codon_to_match
      high = mid - 1
    else
      return true
    end
  end
  false
end

sorted_gene = gene.sort
puts "#{binary_contains(sorted_gene, "ACG")}"
puts "#{binary_contains(sorted_gene,"GAT")}"
