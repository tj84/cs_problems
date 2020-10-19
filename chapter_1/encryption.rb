require 'securerandom'


def random_key(length)
  key = SecureRandom.random_bytes(length)
  key = key.unpack('C*')
end

def encrypt(original)
  original.encode!
  dummy = random_key(original.length)
  original_key = original.unpack('C*')
  encrypted = []
  original_key.each_with_index do |key, i|
    encrypted << (key ^ dummy[i])
  end
  [dummy, encrypted]
end

def decrypt(key1, key2)
  decrypted = []
  key1.each_with_index do |key, i|
    decrypted << (key ^ key2[i])
  end
  decrypted.pack('C*')
end

message = "One time pad!"
puts "Original message: #{message}"
a = encrypt(message)
puts "Decypted message: #{decrypt(a[0],a[1])}"
