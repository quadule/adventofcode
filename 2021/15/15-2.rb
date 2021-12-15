class PriorityQueue
  def initialize
    @queue = []
  end
  def add(priority, item)
    @queue << [priority, @queue.length, item]
  end
  def next
    @queue.shift[2]
  end
  def empty?
    @queue.empty?
  end
  def sort!
    @queue.sort!
  end
end

class RepeatedMap
  def initialize(map)
    @map = map
  end
  def get(x, y)
    risk = @map[y % @map.size][x % @map.first.size] + y / @map.size + x / @map.first.size
    risk > 9 ? risk % 10 + 1 : risk
  end
  def columns
    @map.first.size * 5
  end
  def rows
    @map.size * 5
  end
end

def risk_score(path, map)
  path[1..].map { |(x, y)| map.get(x, y) }.sum
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
    average_cost = risk_score(new_path, map).to_f / new_path.size
    [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |dx, dy|
      x, y = position[0] + dx, position[1] + dy
      next unless y >= 0 && y < map.rows && x >= 0 && x < map.columns
      next if visited[[x, y]]
      new_cost = cost + map.get(x, y)
      priority = new_cost + average_cost
      queue.add(priority, [[x, y], new_path, new_cost])
    end
    queue.sort!
  end
  nil
end

numbers = File.readlines("input.txt", chomp: true).map(&:chars).map { _1.map(&:to_i) }
map = RepeatedMap.new(numbers)
start = [0, 0]
goal = [map.rows - 1, map.columns - 1]
path = find_path(map, start, goal)
puts risk_score(path, map)
