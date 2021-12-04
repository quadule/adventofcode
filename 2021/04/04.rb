class Board
  def initialize(numbers)
    @numbers = numbers
  end

  def mark(draw)
    @numbers.map! do |number|
      number == draw ? nil : number
    end
  end

  def win?
    rows = @numbers.each_slice(5).to_a
    columns = rows.transpose
    (rows + columns).any? { |set| set.all?(&:nil?) }
  end

  def unmarked_sum
    @numbers.compact.sum
  end
end

draws, *boards = File.read("input.txt").split(/\n+/)
draws = draws.split(",").map(&:to_i)
boards = boards.
  map { |line| line.strip.split(/\s+/).map(&:to_i) }.
  reduce(&:+).
  each_slice(25).
  map { |numbers| Board.new(numbers) }
wins = []

until boards.empty? || draws.empty?
  draw = draws.shift
  boards.each { |board| board.mark(draw) }
  new_wins, boards = boards.partition(&:win?)
  puts "Part 1: #{new_wins.first.unmarked_sum * draw}" if new_wins.any? && wins.empty?
  wins += new_wins
end

puts "Part 2: #{wins.last.unmarked_sum * draw}"
