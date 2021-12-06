fish = File.read("input.txt").scan(/\d+/).map(&:to_i).tally

def next_day(fish)
  new_fish = Hash.new(0)
  fish.keys.sort.reverse.each do |age|
    if age == 0
      new_fish[6] += fish[age]
      new_fish[8] += fish[age]
    else
      new_fish[age - 1] = fish[age]
    end
  end
  new_fish
end

1.upto(256) do |day|
  fish = next_day(fish)
  puts "Day #{day}: #{fish.values.sum}"
end
