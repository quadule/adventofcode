lines = File.read("input.txt").lines(chomp: true);
# ingredients = lines.map { |line| line.scan(/([^(]+) \(contains (.*)\)/).flatten }.map { |ingredient, parts| [ingredient, parts.split(", ")] }.to_h
foods = lines.map { |line| line.scan(/([^(]+) \(contains (.*)\)/).flatten }.map { |ingredients, parts| [ingredients.split(" "), parts.split(", ")] }.to_h;


allergens = foods.reduce({}) { |hash, (ingredients, allergens)|
  allergens.each { |allergen|
    hash[allergen] = (hash[allergen] || ingredients) & ingredients
  }
  hash
};

known_ingredients = []
begin
  known, unknown = allergens.partition { |_, ingredients| ingredients.one? }.map(&:to_h)
  known_ingredients = known.values.map(&:first)
  allergens.merge!(unknown.transform_values { |ingredients| ingredients - known_ingredients })
end while allergens.count { |_, ingredients| ingredients.one? } > known_ingredients.size

safe_ingredients = foods.keys.flatten - allergens.values.flatten

puts safe_ingredients.size

puts allergens.sort_by(&:first).map(&:last).join(",")
