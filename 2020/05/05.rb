seat_ids = File.readlines("input.txt").map do |line|
  row = line[0,7].tr("FB", "01").to_i(2)
  col = line[7,3].tr("LR", "01").to_i(2)
  row * 8 + col
end
puts "Part 1: " + seat_ids.max.to_s
puts "Part 2: " + seat_ids.sort.each_cons(2).find { |a, b| b - a != 1 }[0].succ.to_s
