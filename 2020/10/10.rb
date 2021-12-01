joltages = [0] + File.read("input.txt").split.map(&:to_i).sort;
joltages << joltages.last + 3;
differences = joltages.each_cons(2).map { |c| c[1] - c[0] }
# puts differences.count(1) * differences.count(3)

counts = { 0 => 1 }
joltages[1..-2].each do |joltage|
  counts[j] = [counts[j - 1], counts[j - 2], counts[j - 3]].compact.sum
end
puts counts.values.last # => 198428693313536



