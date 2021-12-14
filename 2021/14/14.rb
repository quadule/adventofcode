template, _, *rules = File.readlines("input.txt", chomp: true)
rules = rules.reduce({}) { |hash, rule| pair, element = rule.split(" -> "); hash[pair] = element; hash }

def step(template, rules)
  template.chars.each_cons(2).flat_map.with_index do |(a, b), i|
    [(a if i == 0), rules["#{a}#{b}"], b].compact
  end.join
end

(1..10).each { template = step(template, rules) }
min, max = template.chars.tally.minmax_by(&:last)
puts max.last - min.last
