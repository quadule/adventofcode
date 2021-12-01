INPUT = File.read("input.txt").split.map(&:chars);
FLOOR = "."
EMPTY = "L"
OCCUPIED = "#"

def putseats(seats)
  puts seats.map { |s| s.join }.join("\n")
end

def adjacent_seats(seats, row, column)
  last_row, last_column = seats.size - 1, seats[0].size - 1
  [
    (seats[row - 1][column - 1] if row > 0 && column > 0),
    (seats[row - 1][column]     if row > 0),
    (seats[row - 1][column + 1] if row > 0 && column < last_column),
    (seats[row][column - 1]     if column > 0),
    (seats[row][column + 1]     if column < last_column),
    (seats[row + 1][column - 1] if row < last_row && column > 0),
    (seats[row + 1][column]     if row < last_row),
    (seats[row + 1][column + 1] if row < last_row && column < last_column)
  ].compact
end

def surrounding_seat(seats, row, column, y_direction, x_direction)
  y_range, x_range = 0...seats.size, 0...seats[0].size
  loop do
    row, column = row + y_direction, column + x_direction
    return unless y_range.cover?(row) && x_range.cover?(column)
    return seats[row][column] unless seats[row][column] == FLOOR
  end
end

def surrounding_seats(seats, row, column)
  [
    surrounding_seat(seats, row, column, -1, -1),
    surrounding_seat(seats, row, column, -1,  0),
    surrounding_seat(seats, row, column, -1, +1),
    surrounding_seat(seats, row, column,  0, -1),
    surrounding_seat(seats, row, column,  0, +1),
    surrounding_seat(seats, row, column, +1, -1),
    surrounding_seat(seats, row, column, +1,  0),
    surrounding_seat(seats, row, column, +1, +1),
  ].compact
end

def next_arrangement_part1(all_seats)
  all_seats.map.with_index do |row_seats, row|
    row_seats.map.with_index do |seat, column|
      case seat
      when EMPTY
        adjacent_seats(all_seats, row, column).count(OCCUPIED) == 0 ? OCCUPIED : EMPTY
      when OCCUPIED
        adjacent_seats(all_seats, row, column).count(OCCUPIED) >= 4 ? EMPTY : OCCUPIED
      else
        FLOOR
      end
    end
  end
end

def next_arrangement_part2(all_seats)
  all_seats.map.with_index do |row_seats, row|
    row_seats.map.with_index do |seat, column|
      case seat
      when EMPTY
        surrounding_seats(all_seats, row, column).count(OCCUPIED) == 0 ? OCCUPIED : EMPTY
      when OCCUPIED
        surrounding_seats(all_seats, row, column).count(OCCUPIED) >= 5 ? EMPTY : OCCUPIED
      else
        FLOOR
      end
    end
  end
end

seats = INPUT
loop do
  new_seats = next_arrangement_part2(seats)
  break if new_seats == seats
  seats = new_seats
end

puts "occupied: " + seats.flatten.count(OCCUPIED).to_s