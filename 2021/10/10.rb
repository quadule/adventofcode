lines = File.readlines("input.txt", chomp: true)

def find_illegal_character(line)
  closers = { "(" => ")", "[" => "]", "{" => "}", "<" => ">" }
  openers = closers.invert
  stack = []
  line.chars.find do |char|
    if closers.key?(char)
      stack.push(char)
      nil
    elsif char == closers[stack.last]
      stack.pop
      nil
    else
      char
    end
  end
end

points = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25137 }
illegal_characters = lines.map(&method(:find_illegal_character)).compact
puts illegal_characters.map { |char| points[char] }.sum
