
# def add_next(spoken)
#   last_number = spoken.last
#   previous_index = spoken[0..-2].rindex(last_number)
#   next_number = previous_index ? spoken.size - (previous_index + 1) : 0
#   spoken << next_number
# end


indexes = {}
input = [9,3,1,0,8,4];
# input = [3,1,2]
buffer = input.dup
position = 30000000
# position = 2020
last_number = next_number = input.last
puts input.join(",")
input.size.upto(position) do |i|
  last_number = next_number
  previous_index = indexes[last_number] || input[0..-2].rindex(last_number)
  next_number = previous_index ? i - previous_index - 1 : 0
  indexes[last_number] = i - 1
  # print "#{next_number},"
end
puts "position #{position} = #{last_number}"

