def valid?(policy_string, password)
  first_pos, second_pos, char = policy_string.match(/(\d+)-(\d+) (.)/).captures
  first_char, second_char = password[first_pos.to_i - 1], password[second_pos.to_i - 1]
  (first_char == char) ^ (second_char == char)
end

lines = open("input.txt").read.lines
puts lines.count { |line|
  policy_string, password = line.chomp.split(": ")
  valid?(policy_string, password)
}
