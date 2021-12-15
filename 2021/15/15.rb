class PriorityQueue
  def initialize
    @queue = []
  end
  def add(priority, item)
    @queue << [priority, @queue.length, item]
    @queue.tap(&:sort!)
  end
  def next
    @queue.shift[2]
  end
  def empty?
    @queue.empty?
  end
end

def find_path(map, start, goal)
  visited = {}
  queue = PriorityQueue.new
  queue.add(1, [start, [], 0])
  while !queue.empty?
    position, path, cost = queue.next
    next if visited[position]
    new_path = path + [position]
    return new_path if position == goal
    visited[position] = true
    [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |x, y|
      x, y = x + position[0], y + position[1]
      next unless y >= 0 && y < map.size && x >= 0 && x < map.first.size
      next if visited[[x, y]]
      new_cost = cost + map[y][x]
      queue.add(new_cost + 1, [[x, y], new_path, new_cost])
    end
  end
  nil
end

def risk_score(path, map)
  path[1..].map { |x, y| map[y][x] }.sum
end

map = File.readlines("input.txt", chomp: true).map(&:chars).map { _1.map(&:to_i) }
start = [0, 0]
goal = [map.size - 1, map.last.size - 1]
puts risk_score(find_path(map, start, goal), map)
