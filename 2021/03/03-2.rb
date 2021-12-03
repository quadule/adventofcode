all_numbers = File.readlines("input.txt", chomp: true)

def find_oxygen_bit(numbers, position)
  bits = numbers.map(&:chars).transpose
  bit_values = bits[position].sort
  zeros, ones = bit_values.count("0"), bit_values.count("1")
  zeros > ones ? "0" : "1"
end

def find_co2_bit(numbers, position)
  bits = numbers.map(&:chars).transpose
  bit_values = bits[position].sort
  zeros, ones = bit_values.count("0"), bit_values.count("1")
  zeros > ones ? "1" : "0"
end

oxygen_ratings = all_numbers
position = 0
while oxygen_ratings.size > 1
  oxygen_bit = find_oxygen_bit(oxygen_ratings, position)
  oxygen_ratings = oxygen_ratings.filter do |rating|
    rating[position] == oxygen_bit
  end
  position += 1
end
oxygen_rating = oxygen_ratings.first
puts oxygen_rating

co2_ratings = all_numbers
position = 0
while co2_ratings.size > 1
  co2_bit = find_co2_bit(co2_ratings, position)
  co2_ratings = co2_ratings.filter do |rating|
    rating[position] == co2_bit
  end
  position += 1
end
co2_rating = co2_ratings.first
puts co2_rating

puts oxygen_rating.to_i(2) * co2_rating.to_i(2)
