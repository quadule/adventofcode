octopuses = File.read("input.txt").scan(/\d/).map(&:to_i).each_slice(10).to_a

def adjacent_positions(octopuses, x, y)
  last_y, last_x = octopuses.size - 1, octopuses[0].size - 1
  [
    ([x - 1, y - 1] if y > 0 && x > 0),
    ([x, y - 1]     if y > 0),
    ([x + 1, y - 1] if y > 0 && x < last_x),
    ([x - 1, y]     if x > 0),
    ([x + 1, y]     if x < last_x),
    ([x - 1, y + 1] if y < last_y && x > 0),
    ([x, y + 1]     if y < last_y),
    ([x + 1, y + 1] if y < last_y && x < last_x)
  ].compact
end

def flash_positions(octopuses)
  octopuses.flat_map.with_index { |row, y| row.map.with_index { |level, x| [x,y] if level > 9 } }.compact
end

def step(octopuses)
  octopuses = octopuses.map { |row| row.map(&:succ) }
  flashes = []
  loop do
    new_flashes = flash_positions(octopuses) - flashes
    break if new_flashes.empty?
    adjacent_positions = new_flashes.flat_map { |(x, y)| adjacent_positions(octopuses, x, y) }
    adjacent_positions.each { |(x, y)| octopuses[y][x] += 1 }
    flashes += new_flashes
  end
  flashes.each { |(x, y)| octopuses[y][x] = 0 }
  octopuses
end

flash_count = 0
steps = 0
100.times {
  octopuses = step(octopuses)
  flash_count += octopuses.flatten.count(&:zero?)
  steps += 1
}
puts "Part 1: #{flash_count}"

begin
  octopuses = step(octopuses)
  steps += 1
end until octopuses.flatten.all?(&:zero?)

puts "Part 2: #{steps}"
