class NucleotideValue < Exception
end

class CompressedGene
  attr_reader :gene

  def initialize(gene)
    @gene = gene
    @gene = compress(gene)
  end

  def to_s
    decompress
  end

  def decompress
    gene = ""
    @gene = @gene.to_s(2) # convert to base 2
    @gene = @gene[1..-1] # drop sentinel value
    @gene.chars.each_slice(2).map(&:join).each do |nucleotide|
      nucleotide = nucleotide.to_i & 0b11
      case nucleotide
      when 0b00
        gene += "A"
      when 0b01
        gene += "C"
      when 0b10
        gene += "G"
      when 0b11
        gene += "T"
      else
        raise NucleotideValue, "Invalid Nucleotide #{nucleotide}"
      end
    end
    gene
  end

  private

  def compress(gene)
    bit_string = 1 # sentinel value
    @gene.upcase.each_char do |nucleotide|
      bit_string <<= 2
      case nucleotide
      when "A"
        bit_string |= 0b00
      when "C"
        bit_string |= 0b01
      when "G"
        bit_string |= 0b10
      when "T"
        bit_string |= 0b11
      else
        raise NucleotideValue, "Invaid Nucleotide #{nucleotide}"
      end
    end
    bit_string
  end
end

gene = "TAGGGATTAACCGTTATATATATATAGCCATGGATCGATTATATAGGGATTAACCGTTATATATATATAGCCATGGATCGATTATA" * 100

puts "The uncompressed gene is #{gene.bytesize} bytes."
compressor = CompressedGene.new(gene)
compressed_gene = compressor.gene
puts "The compressed gene is #{compressed_gene.size} bytes."
uncompressed_gene = compressor.decompress
puts "The uncompressed and origianl gene are the same size: #{gene.bytesize == uncompressed_gene.bytesize}."
