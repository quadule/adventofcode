tiles = File.read("input.txt").lines(chomp: true).reject(&:empty?).each_slice(11).map { |header, *lines|
  [header[/\d+/, 0].to_i, lines.map(&:chars)]
}.to_h;

def orientations(tile)
  Enumerator.new do |e|
    e.yield tile
    e.yield tile.reverse
    e.yield tile.reverse.transpose
    e.yield tile.transpose
    e.yield tile.transpose.reverse
    e.yield tile.map(&:reverse)
    e.yield tile.map(&:reverse).reverse
    e.yield tile.map(&:reverse).reverse.transpose
  end
end

def edge_combinations(a, b)
  Enumerator.new do |e|
    orientations(a).each do |orientation_a|
      orientations(b).each do |orientation_b|
        e.yield orientation_a[0], orientation_b[0]
      end
    end
  end
end

corner_ids = tiles.sort_by { |id, tile|
  (tiles.values - tile).count { |other| edge_combinations(tile, other).any?(&:eql?) }
}.first(4).map(&:first)

puts corner_ids.reduce(:*)