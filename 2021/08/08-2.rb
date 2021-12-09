lines = File.readlines("input.txt", chomp: true)
entries = lines.map do |entry|
  entry.split(" | ").map do |part|
    part.split(" ").map { |signal| signal.chars.sort.to_set }
  end
end

output_values = entries.map do |entry|
  patterns, output = entry
  key = []
  key[1] = patterns.find { _1.size == 2 }
  key[4] = patterns.find { _1.size == 4 }
  key[7] = patterns.find { _1.size == 3 }
  key[8] = patterns.find { _1.size == 7 }
  key[3] = patterns.find { _1.size == 5 && _1 > key[1] }
  key[2] = patterns.find { _1.size == 5 && (_1 & key[4]).size == 2 }
  key[5] = patterns.find { _1.size == 5 && (_1 & key[2]).size == 3 }
  key[9] = patterns.find { _1.size == 6 && _1 > key[4] }
  key[6] = patterns.find { _1.size == 6 && _1 != key[9] && _1 > key[5] }
  key[0] = patterns.find { _1.size == 6 && _1 != key[6] && _1 != key[9] }
  output.map { |digit| key.index(digit) }.join.to_i
end

puts output_values.sum
