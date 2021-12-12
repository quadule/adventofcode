lines = File.readlines("input.txt", chomp: true)
def big?(str); str =~ /^[A-Z]+$/; end
def small?(str); str =~ /^[a-z]{1,2}$/; end
connections = Hash.new { [] }
lines.each do |line|
  from, to = line.split("-")
  connections[from] |= [to]
  connections[to] |= [from]
end

def paths(connections, path: ["start"], from: "start", to: "end")
  visited_small = path.reject(&method(:big?))
  branches = connections[from] - visited_small
  return path if path.last == to
  return path + [to] if branches == [to]
  branches.flat_map do |cave|
    paths(connections, path: path + [cave], from: cave, to: to)
  end
end

all_paths = paths(connections).chunk_while { _1 != "end" && _2 != "start" }.to_a.map { _1.join(",") }
puts "Part 1: #{all_paths.size}"

def paths2(connections, path: ["start"], from: "start", to: "end")
  visited_small = path.select(&method(:small?)).tally
  twice_visited = visited_small.select { |k, v| v > 1 }.keys
  branches = connections[from].reject { |node| node == "start" || twice_visited.any? && visited_small.fetch(node, 0) >= 1 }
  return path if path.last == to
  return path + [to] if branches == [to]
  branches.flat_map do |cave|
    paths2(connections, path: path + [cave], from: cave, to: to)
  end
end

all_paths = paths2(connections).chunk_while { _1 != "end" && _2 != "start" }.to_a.map { _1.join(",") }
puts "Part 2: #{all_paths.size}"
