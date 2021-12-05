def count_overlaps(lines, diagonals: false)
  diagram = Hash.new(0)
  lines.each do |line|
    (x1, y1), (x2, y2) = line.split(" -> ").map { |pair| pair.split(",").map(&:to_i) }
    if x1 == x2
      Range.new(*[y1, y2].sort).each { |y| diagram[[x1, y]] += 1 }
    elsif y1 == y2
      Range.new(*[x1, x2].sort).each { |x| diagram[[x, y1]] += 1 }
    elsif diagonals
      x_values = x1.step(x2, x2 <=> x1).to_a
      y_values = y1.step(y2, y2 <=> y1).to_a
      x_values.zip(y_values).each do |point|
        diagram[point] += 1
      end
    end
  end
  diagram.count { |_, overlaps| overlaps >= 2 }
end

lines = File.readlines("input.txt", chomp: true)
puts "Part 1: #{count_overlaps(lines)}"
puts "Part 2: #{count_overlaps(lines, diagonals: true)}"
