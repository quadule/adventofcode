input = File.read("input.txt")
numbers = input.lines.reject(&:empty?).map(&:to_i)
part_1 = numbers.each_cons(2).count { |a, b| b > a }
puts "Part 1: #{part_1}"

part_2 = numbers.each_cons(3).map(&:sum).each_cons(2).count { |a, b| b > a }
puts "Part 2: #{part_2}"
