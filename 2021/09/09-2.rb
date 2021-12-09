lines = File.readlines("input.txt", chomp: true)
heightmap = lines.map { |line| line.scan(/\d/).map(&:to_i) }

def adjacent_points(heightmap, x, y)
  [
          [x,y-1],
    [x-1,y],    [x+1,y],
          [x,y+1]
  ].select { |x, y| x >= 0 && y >= 0 && heightmap[y] && heightmap[y][x] }
end

low_points = heightmap.flat_map.with_index do |row, y|
  row.map.with_index do |height, x|
    [x, y] if adjacent_points(heightmap, x, y).all? { |(x, y)| heightmap[y][x] > height }
  end.compact
end

def find_low_point(point, heightmap, low_points)
  x, y = point
  return nil if heightmap[y][x] == 9
  adjacent = []
  begin
    adjacent = adjacent_points(heightmap, *point)
    point = adjacent.min_by { |(x, y)| heightmap[y][x] }
  end until adjacent.empty? || low_points.include?(point)
  point
end

# maps [x,y] of low point to [[x,y], ...] of basin points
basins = Hash.new { [] }

heightmap.each.with_index do |row, y|
  row.each.with_index do |height, x|
    low_point = find_low_point([x, y], heightmap, low_points)
    next unless low_point
    basins[low_point] |= [[x, y]]
  end
end

puts basins.values.map(&:size).sort.last(3).reduce(&:*)
