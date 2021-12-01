include Math

instructions = File.readlines("input.txt").map do |line|
  action, value = line.match(/(\w)(\d+)/).captures
  [action.to_sym, value.to_i]
end;

State = Struct.new(:x, :y, :degrees, :wx, :wy)
state = State.new(0, 0, 0, 10, 1)

def move_pt1(old_state, action, value)
  old_state.dup.tap do |state|
    case action
    when :N then state.y += value
    when :S then state.y -= value
    when :E then state.x += value
    when :W then state.x -= value
    when :L then state.degrees = (state.degrees + value) % 360
    when :R then state.degrees = (state.degrees - value) % 360
    when :F
      radians = state.degrees * (PI / 180)
      state.x += cos(radians) * value
      state.y += sin(radians) * value
    end
  end
end

def rotate(state, degrees)
  radians = degrees * (PI / 180)
  x, y = state.wx, state.wy
  state.wx = (x * cos(radians) - y * sin(radians)).round
  state.wy = (y * cos(radians) + x * sin(radians)).round
  state
end

def move_pt2(old_state, action, value)
  old_state.dup.tap do |state|
    case action
    when :N then state.wy += value
    when :S then state.wy -= value
    when :E then state.wx += value
    when :W then state.wx -= value
    when :L then rotate(state, +value)
    when :R then rotate(state, -value)
    when :F
      state.x += state.wx * value
      state.y += state.wy * value
    end
  end
end

def manhattan_distance(state)
  state.x.abs + state.y.abs
end

instructions.each do |action, value|
  new_state = move_pt2(state, action, value)
  puts "state: #{state} #{action}#{value} => #{new_state}"
  state = new_state
end;

puts "manhattan: #{manhattan_distance(state)}"