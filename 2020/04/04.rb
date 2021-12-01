rules = {
  "byr" => -> (value) { value.to_i.between?(1920, 2002) },
  "iyr" => -> (value) { value.to_i.between?(2010, 2020) },
  "eyr" => -> (value) { value.to_i.between?(2020, 2030) },
  "hgt" => -> (value) { (value =~ /cm$/ && value.to_i.between?(150, 193)) || (value =~ /in$/ && value.to_i.between?(59, 76)) },
  "hcl" => /^\#[0-9a-f]{6}$/,
  "ecl" => /^(amb|blu|brn|gry|grn|hzl|oth)$/,
  "pid" => /^\d{9}$/,
}

passports = File.read("input.txt").split("\n\n").map do |passport|
  passport.scan(/(\w+)\:(\S+)/).to_h
end

valid_passports = passports.filter do |passport|
  rules.all? { |key, rule| rule === passport[key] }
end

puts valid_passports.size
