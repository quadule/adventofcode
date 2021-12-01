lines = File.readlines("input.txt");

memory = {}
zeros_mask = 0
ones_mask = 0

# lines.each do |line|
#   command, *args = line.scan(/\w+/)
#   case command
#   when "mask"
#     zeros_mask = args.first.tr("01X", "100").to_i(2)
#     ones_mask  = args.first.tr("X", "0").to_i(2)
#   when "mem"
#     address, value = args[0].to_i, args[1].to_i
#     value &= ~zeros_mask
#     value |= ones_mask
#     memory[address] = value
#   end
# end

mask = "000000000000000000000000000000000000"
bit_positions = []
lines.each do |line|
  command, *args = line.scan(/\w+/)
  case command
  when "mask"
    mask = args.first
    ones_mask = mask.tr("X", "0").to_i(2)
    bit_positions = mask.chars.reverse_each.map.with_index { |bit, i| i if bit == "X" }.compact
  when "mem"
    base_address, value = args[0].to_i, args[1].to_i
    base_address |= ones_mask
    count = 2 ** mask.count("X")
    count.times do |address_number|
      address = base_address
      bit_positions.each.with_index do |bit_position, index|
        bit_mask = 1 << bit_position
        if address_number[index].zero?
          address &= ~bit_mask
        else
          address |= bit_mask
        end
      end
      memory[address] = value
    end

  end
end

puts memory.values.sum
