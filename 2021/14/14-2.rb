template, _, *rules = File.readlines("input.txt", chomp: true)
rules = rules.reduce({}) { |hash, rule| pair, element = rule.split(" -> "); hash[pair] = element; hash }

def step(counts, rules)
  new_counts = counts.dup.tap { |h| h.default = 0 }
  counts.each.with_index.reduce(new_counts) do |hash, ((str, count), i)|
    if str.size > 1 && count > 0 && (insertion = rules[str])
      hash[str] -= count
      left, right = str.chars
      hash[insertion] += count
      hash["#{left}#{insertion}"] += count
      hash["#{insertion}#{right}"] += count
    end
    hash
  end
end

counts = template.chars.each_cons(2).map(&:join).tally.merge(template.chars.tally)
(1..40).each { counts = step(counts, rules) }
min, max = counts.select { |str, _count| str.size == 1 }.minmax_by(&:last)
puts max.last - min.last
