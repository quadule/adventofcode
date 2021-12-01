# bag_contents = Hash.new { [] }
# File.read("input.txt").gsub(/\.$/m, '').split(/\.?\n+/).each do |rule|
#   container, contained = rule.gsub("bags", "bag").split(/\.?\n+/).map { |l| l.split(" contain ") }.flatten
#   contained = contained.gsub(/\d+ /, '').split(", ")
#   contained.grep_v("no other bag").each do |contained_bag|
#     bag_contents[container] |= [contained_bag]
#   end
# end


# def find_containers(bag_contents, bag, level = 0)
#   bag_contents.flat_map do |container, contained|
#     if contained.include?(bag)
#       [container] + find_containers(bag_contents, container, level + 1)
#     else
#       nil
#     end
#   end.compact.uniq
# end

# puts find_containers(bag_contents, "shiny gold bag").size

def bags_from_description(desc)
  match = desc.match(/^\d+ /)
  [match.post_match] * match[0].to_i
end

bag_contents = Hash.new { [] }
File.read("input.txt").split(/\.?\n+/).each do |rule|
  container, contained = rule.gsub("bags", "bag").split(/\.?\n+/).map { |l| l.split(" contain ") }.flatten
  contained = contained.split(", ")
  contained.grep_v("no other bag").each do |contained_bag|
    bag_contents[container] += bags_from_description(contained_bag)
  end
end

def find_contents(bag_contents, bag, level = 0)
  bag_contents[bag].map do |contained_bag|
    if bag_contents[contained_bag].empty?
      contained_bag
    else
      [contained_bag] + find_contents(bag_contents, contained_bag, level + 1)
    end
  end
end

puts find_contents(bag_contents, "shiny gold bag").flatten.size