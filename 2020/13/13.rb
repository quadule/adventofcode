earliest_time, buses = File.read("input.txt").split
earliest_time = earliest_time.to_i
buses = buses.split(",").map(&:to_i);

def time_to_wait(earliest_time, bus)
  bus - earliest_time % bus
end

earliest_bus = buses.reject(&:zero?).min_by { |bus| time_to_wait(earliest_time, bus) }
shortest_wait = time_to_wait(earliest_time, earliest_bus)
# puts earliest_bus * shortest_wait

start = 0
increment = 1
found = 0

while found < buses.reject(&:zero?).size
  (start..).step(increment) do |timestamp|
    current_buses = buses.select.with_index do |number, index|
      number > 0 && (timestamp + index) % number == 0
    end
    if current_buses.size > found
      increment = current_buses.reduce(1, :lcm)
      found = current_buses.size
      start = timestamp
      puts "t = #{timestamp}; buses = #{current_buses}"
      break
    end
  end
end
