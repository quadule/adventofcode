lines = File.readlines("input.txt", chomp: true)
dots, folds = lines.partition { _1.include?(",") }
dots = dots.map { _1.split(",").map(&:to_i) }
folds = folds.reject(&:empty?).map { _1.scan(/(x|y)=(\d+)$/).first }

columns, rows = dots.map(&:first).max + 1, dots.map(&:last).max + 1
paper = Array.new(rows) { Array.new(columns) }
dots.each { |(x, y)| paper[y][x] = "#" }

def fold(paper, fold_axis, fold_position)
  if fold_axis == "y"
    a, b = paper.first(fold_position).reverse, paper.last(paper.size - fold_position - 1)
    [a.size, b.size].max.times.map do |y|
      paper.first.size.times.map do |x|
        (a[y] && a[y][x] || b[y] && b[y][x]) ? "#" : nil
      end
    end.reverse
  else
    fold(paper.transpose, "y", fold_position).transpose
  end
end

folds.each.with_index do |(fold_axis, fold_position), step|
  paper = fold(paper, fold_axis, fold_position.to_i)
  puts paper.flatten.compact.size
end
puts paper.map { |row| row.map { |cell| cell || " " }.join }
