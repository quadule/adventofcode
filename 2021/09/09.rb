lines = File.readlines("input.txt", chomp: true)
heightmap = lines.map { |line| line.scan(/\d/).map(&:to_i) }

def adjacent_points(heightmap, x, y)
  [
          [x,y-1],
    [x-1,y],    [x+1,y],
          [x,y+1]
  ].select { |x, y| x >= 0 && y >= 0 && heightmap[y] && heightmap[y][x] }
end

risk_levels = heightmap.map.with_index do |row, y|
  row.map.with_index do |height, x|
    adjacent_points(heightmap, x, y).all? { |(x, y)| heightmap[y][x] > height } ? 1 + height : 0
  end
end

puts risk_levels.flatten.sum
