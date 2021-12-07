def cost(p1, p2)
  distance = (p1 - p2).abs
  (1..distance).sum
end

positions = File.read("input.txt").scan(/\d+/).map(&:to_i)
costs = (positions.min..positions.max).to_h do |target|
  [target, positions.map { |p| cost(target, p) }.sum]
end
target, fuel = costs.min_by(&:last)
puts fuel
