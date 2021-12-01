expenses = open("expenses.txt").read.lines.map(&:to_i)
entries = expenses.combination(3).find { |numbers| numbers.sum == 2020 }
puts entries.reduce(:*)