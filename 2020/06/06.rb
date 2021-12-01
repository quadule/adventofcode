# groups = File.read("input.txt").split("\n\n").map do |group|
#   group.gsub("\n", "").chars.uniq.size
# end
# puts groups.sum

groups = File.read("input.txt").split("\n\n").map do |group|
  group.split.map(&:chars).reduce(:&).size
end
puts groups.sum
