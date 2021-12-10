lines = File.readlines("input.txt", chomp: true)
points = { ")" => 1, "]" => 2, "}" => 3, ">" => 4}
closers = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }
openers = closers.invert

scores = lines.map do |line|
  stack = []
  corrupted = line.chars.find do |char|
    if closers.key?(char)
      stack.push(char) && false
    elsif char == closers[stack.last]
      stack.pop && false
    else
      true
    end
  end
  next if corrupted
  completion = stack.reverse.map { |char| closers[char] }
  completion.reduce(0) { |sum, char| sum * 5 + points[char] }
end.compact

puts scores.sort[scores.size / 2]
