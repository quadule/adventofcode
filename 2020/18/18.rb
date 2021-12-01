# require "byebug"
TOKEN = /\d+|\S/
NUMBER = /\d+/
OPERATOR = /[+*]/
SYMBOL = /[+*()]/
lines = File.read("input.txt").lines;

PARENTHESES = /\((\d+( . \d+)+)\)/
ADDITION = /(\d+) \+ (\d+)/
MULTIPLICATION = /(\d+) \* (\d+)/
NUMBER_ONLY = /\((\d+)\)/

def calculate(line)
  begin
    begin
      puts "( ) #{line}"
    end while line.sub!(NUMBER_ONLY) { $1 } || line.sub!(PARENTHESES) { calculate($1) }
    begin
      puts "[+] #{line}"
    end while line.sub!(ADDITION) { $1.to_i + $2.to_i }
    begin
      puts "[*] #{line}"
    end while line.sub!(MULTIPLICATION) { $1.to_i * $2.to_i }
  end while PARENTHESES == line || ADDITION === line || MULTIPLICATION === line
  line.to_i
end





# def calculate(tokens)
#   depth = 0
#   stack = []
#   while tokens.any?
#     case token = tokens.shift
#     when NUMBER, Numeric
#       number = token.to_i
#       if stack.size >= 2 && NUMBER === stack[-2].to_s && OPERATOR === stack[-1]
#         other_number, operator = stack.pop(2)
#         result = other_number.to_i.send(operator, number)
#         stack << result
#       else
#         stack << number
#       end
#     when OPERATOR
#       stack << token
#     when "("
#       stack << token
#       depth += 1
#     when ")"
#       stack.slice!(stack.rindex("("))
#       depth -= 1
#       if stack.size > 2 && OPERATOR === stack[-2]
#         tokens.unshift(stack.pop)
#       end
#     end
#   end
#   if stack.one?
#     stack.first
#   else
#     calculate(stack)
#   end
# end

puts(lines.sum do |line|
  calculate(line)
end)

# # puts "expected: 59306292"
# # puts calculate("6 * ((5 * 3 * 2 + 9 * 4) * (8 * 8 + 2 * 3) * 5 * 8) * 2 + (4 + 9 * 5 * 5 + 8) * 4")
# puts calculate("2 * 3 + (4 * 5)")
# puts
# puts calculate("5 + (8 * 3 + 9 + 3 * 4 * 3)")
# puts
# puts calculate("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")
# puts
# puts calculate("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")