lines = File.readlines("input.txt").map(&:chomp)
# accumulator, position = 0, 0
# visited_positions = []
# accumulator_values = []
# loop do
#   line = lines[position]
#   if line.nil?
#     puts "terminated! last positions:"
#     puts visited_positions.last(20).inspect
#     puts "terminated! accumulator values:"
#     puts accumulator_values.last(20).inspect
#     break
#   end
#   puts line + " -- position=#{position} accumulator=#{accumulator}"
#   if visited_positions.include?(position)
#     puts "loop detected! last positions:"
#     puts visited_positions.last(20).inspect
#     puts "loop detected! accumulator values:"
#     puts accumulator_values.last(20).inspect
#     break
#   end
#   visited_positions |= [position]
#   accumulator_values << accumulator
#   instruction, argument = line.split(/\s/)
#   case instruction
#   when "acc"
#     accumulator += argument.to_i
#     position += 1
#   when "jmp"
#     position += argument.to_i
#   else
#     position += 1
#   end
# end

def terminates?(lines)
  accumulator, position = 0, 0
  visited_positions = []
  accumulator_values = []
  loop do
    line = lines[position]
    if line.nil?
      puts "terminated! last positions:"
      puts visited_positions.last(20).inspect
      puts "terminated! accumulator values:"
      puts accumulator_values.last(20).inspect
      return true
    end
    puts line + " -- position=#{position} accumulator=#{accumulator}"
    if visited_positions.include?(position)
      puts "loop detected! last positions:"
      puts visited_positions.last(20).inspect
      puts "loop detected! accumulator values:"
      puts accumulator_values.last(20).inspect
      return false
    end
    visited_positions |= [position]
    accumulator_values << accumulator
    instruction, argument = line.split(/\s/)
    case instruction
    when "acc"
      accumulator += argument.to_i
      position += 1
    when "jmp"
      position += argument.to_i
    else
      position += 1
    end
  end
end

lines.size.times do |i|
  modified = lines.dup
  if modified[i].start_with?("jmp")
    modified[i] = modified[i].sub("jmp", "nop")
  elsif modified[i].start_with?("nop")
    modified[i] = modified[i].sub("nop", "jmp")
  end
  break if terminates?(modified)
end
