class PriorityQueue
  def initialize; @queue = []; end
  def empty?; @queue.empty?; end
  def shift; @queue.shift; end
  def add(priority, item)
    position = @queue.bsearch_index { (_1[0] <=> priority) > 0 } || @queue.length
    @queue.insert(position, [priority, item])
  end
end

class CavernMap
  def initialize(map)
    @map, @map_rows, @map_cols = map, map.size, map.first.size
    @rows, @cols = @map_rows * 5, @map_cols * 5
    @start, @goal = [0, 0], [@rows - 1, @cols - 1]
    @moves = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def get(x, y)
    risk = @map[y % @map_rows][x % @map_cols] + y / @map_rows + x / @map_cols
    risk -= 9 while risk > 9
    risk
  end

  def safest_path
    queue, visited = PriorityQueue.new, {}
    queue.add(0, [@start, []])
    while !queue.empty?
      risk, (position, path) = *queue.shift
      next if visited.include?(position)
      new_path = path + [position]
      return [risk, new_path] if position == @goal
      visited[position] = true
      @moves.each do |dx, dy|
        x, y = position[0] + dx, position[1] + dy
        next unless y >= 0 && y < @rows && x >= 0 && x < @cols
        new_position = [x, y]
        next if visited.include?(new_position)
        queue.add(risk + get(x, y), [new_position, new_path])
      end
    end
    nil
  end
end

map = CavernMap.new(File.readlines("input.txt", chomp: true).map { _1.chars.map(&:to_i) })
risk, path = map.safest_path
puts risk
