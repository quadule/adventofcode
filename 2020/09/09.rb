numbers = File.read("input.txt").split.map(&:to_i)
# preamble = numbers.shift(25)
# numbers.each.with_index do |n, i|
#   combinations = preamble.combination(2).map(&:sum)
#   if combinations.include?(n)
#     puts "found #{n}, continuing"
#   else
#     puts "#{n} not found"
#     break
#   end
#   preamble.shift
#   preamble.push(n)
# end



sum = 14144619
set = []

2.upto(100) { |i| if (n = numbers.each_cons(i).find { |p| p.sum == sum })
