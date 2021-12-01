Vector = Struct.new(:x, :y)
lines = File.readlines("input.txt").map(&:chomp)

def count_trees(lines, slope)
  position = Vector.new(0, 0)
  trees = 0
  while position.y < lines.size
    line = lines[position.y]
    trees += 1 if line[position.x % line.size] == "#"
    position.x += slope.x
    position.y += slope.y
  end
  trees
end

slopes = [
  Vector.new(1, 1),
  Vector.new(3, 1),
  Vector.new(5, 1),
  Vector.new(7, 1),
  Vector.new(1, 2)
]

trees = slopes.map { |slope| count_trees(lines, slope) }
puts trees.reduce(&:*)