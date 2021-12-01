input = File.read("input.txt");
fields = {}

rules = input.scan(/^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)/).map do |field, *values|
  values = values.map(&:to_i)
  fields[field] = [values[0]..values[1], values[2]..values[3]]
end

your_ticket = input[/your ticket:\n(.*)\n/, 1].split(",").map(&:to_i);

nearby_tickets = input.split("nearby tickets:\n").last.lines.map { |line| line.split(",").map(&:to_i) };

def valid_field?(field_value, rule_set)
  rule_set.any? do |range|
    range.include?(field_value)
  end
end

def valid_ticket?(ticket, rules)
  ticket.all? do |field_value|
    rules.any? do |rule_set|
      valid_field?(field_value, rule_set)
    end
  end
end


invalid_tickets_values = nearby_tickets.flat_map do |ticket|
  ticket.select do |field_value|
    rules.all? do |rule_set|
      rule_set.all? do |range|
        !range.cover?(field_value)
      end
    end
  end
end;

# puts invalid_tickets_values.inspect;
# puts invalid_tickets_values.sum;

pp fields;

valid_tickets = nearby_tickets.select { |ticket| valid_ticket?(ticket, rules) } << your_ticket;
$valid_ticket_columns = Array.new(your_ticket.size).map.with_index { |_, i| valid_tickets.map { |t| t[i] } };

def matching_columns(rule_set)
  $valid_ticket_columns.map.with_index do |values, i|
    values.all? { |v| valid_field?(v, rule_set) } ? i : nil
  end.compact
end

field_columns = fields.transform_values(&method(:matching_columns));

while !field_columns.values.all?(&:one?)
  found_columns, search_columns = field_columns.values.partition(&:one?)
  found_columns.flatten.each do |found|
    search_columns.each { |arr| arr.delete(found) }
  end
end

field_columns.transform_values!(&:first)

puts your_ticket.values_at(*field_columns.values.first(6)).inject(&:*)