entries = File.readlines("input.txt", chomp: true).map do |entry|
  entry.split(" | ").map do |part|
    part.split(" ")
  end
end
output_digits = entries.flat_map(&:last)
puts output_digits.map(&:size).count { [2, 4, 3, 7].include? _1 }
