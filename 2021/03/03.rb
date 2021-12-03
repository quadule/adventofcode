input = File.readlines("input.txt", chomp: true)
bits = input.map(&:chars).transpose

gamma_bits = bits.map do |bit_values|
  counts = bit_values.group_by(&:itself).transform_values(&:size)
  most_common_bit = counts.max_by(&:last).first
end.join
gamma = gamma_bits.to_i(2)
puts "gamma = #{gamma_bits} = #{gamma}"

epsilon_bits = bits.map do |bit_values|
  counts = bit_values.group_by(&:itself).transform_values(&:size)
  most_common_bit = counts.min_by(&:last).first
end.join
epsilon = epsilon_bits.to_i(2)
puts "epsilon = #{epsilon_bits} = #{epsilon}"
puts "product = #{gamma * epsilon}"
