def median(array)
  sorted = array.sort
  len = sorted.length
  ((sorted[(len - 1) / 2] + sorted[len / 2]) / 2)
end

positions = File.read("input.txt").scan(/\d+/).map(&:to_i)
target = median(positions)
fuel = positions.map { |p| (p - target).abs }.sum
puts fuel
