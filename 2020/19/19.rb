require "byebug"
input = File.read("input.txt");
# input = File.read("test.txt");

rules = input.scan(/^(\d+): (.*)/).map do |(number, rule_string)|
  rule = /"(.)"/ === rule_string ? [$1] : rule_string.split(" | ").map { |option| option.split(/\s/).map(&:to_i) }
  [number.to_i, rule]
end.to_h

# Returns nil if a rule does not match at all
# Returns any remaining message if the rule matches the message prefix
# Returns an empty string if the rule fully matches the message
def rule_match(rules, rule_number, message)
  options = rules[rule_number]
  # puts "rules[#{rule_number}] = #{options}, message = #{message}"
  options.each do |option|
    # puts "  checking #{option}"
    case option
    when Integer
      return rule_match(rules, option, message)
    when String
      # byebug
      return message.delete_prefix(option) if message.index(option) == 0
    when Array
      # byebug
      remaining_message = message.dup
      rule_sequence = option.dup
      begin
        rule = rule_sequence.shift
        if (remaining_message = rule_match(rules, rule, remaining_message))
          position = message.size - remaining_message.size
          # puts "  matched #{rules[rule]} at #{position}, remaining_message = #{remaining_message}"
          # byebug if remaining_message.size == 1
          # x=1
        end
        # puts
      end until !remaining_message || remaining_message.empty? || rule_sequence.empty?
      # byebug
      return remaining_message if remaining_message
    end
  end
  nil
end

messages = input.split("\n\n")[1].lines(chomp: true);

# puts rule_match(rules, 0, messages[2]);
puts messages.count { |message| rule_match(rules, 0, message)&.size&.zero? }

# input = File.read("test.txt");