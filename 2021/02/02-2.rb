input = File.read("input.txt")
lines = input.lines.each(&:chomp!)

class Submarine
  def initialize
    @position, @depth, @aim = 0, 0, 0
  end

  attr_reader :position, :depth

  def forward(distance)
    @position += distance
    @depth += aim * distance
  end
  def down(distance); @aim += distance; end
  def up(distance); @aim -= distance; end
end

submarine = Submarine.new
lines.each do |line|
  command, distance = line.split(" ")
  distance = distance.to_i
  submarine.send(command, distance)
end

puts "Position: #{submarine.position}"
puts "Depth: #{submarine.depth}"
puts "Answer: #{submarine.position * submarine.depth}"
