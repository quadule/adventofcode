def valid?(policy_string, password)
  min, max, character = policy_string.match(/(\d+)-(\d+) (.)/).captures
  count = password.chars.count(character)
  count >= min.to_i && count <= max.to_i
end

lines = open("input.txt").read.lines
puts lines.count { |line|
  policy_string, password = line.chomp.split(": ")
  valid?(policy_string, password)
}
