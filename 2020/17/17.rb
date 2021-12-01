ACTIVE = '#'
INACTIVE = '.'
lines = File.read("input.txt").lines
cubes_zyx = Hash.new { INACTIVE }

lines.each.with_index do |line, y|
  line.scan(/./).each.with_index do |cube, x|
    cubes_zyx[[0, y, x]] = cube
  end
end;

def putcubes(cubes_zyx)
  min_z, max_z = cubes_zyx.keys.map { |(z, y, x)| z }.minmax
  min_y, max_y = cubes_zyx.keys.map { |(z, y, x)| y }.minmax
  min_x, max_x = cubes_zyx.keys.map { |(z, y, x)| x }.minmax
  min_z.upto(max_z) do |z|
    puts "\nz=#{z}"
    min_y.upto(max_y).each do |y|
      min_x.upto(max_x).each do |x|
        print cubes_zyx[[z, y, x]]
      end
      puts
    end
  end
  nil
end

# putcubes cubes_zyx

def cycle(cubes_zyx)
  new_cubes = cubes_zyx.dup
  min_z, max_z = cubes_zyx.keys.map { |(z, y, x)| z }.minmax
  min_y, max_y = cubes_zyx.keys.map { |(z, y, x)| y }.minmax
  min_x, max_x = cubes_zyx.keys.map { |(z, y, x)| x }.minmax
  (min_z - 1).upto(max_z + 1) do |z|
    (min_y - 1).upto(max_y + 1) do |y|
      (min_x - 1).upto(max_x + 1) do |x|
        key = [z, y, x]
        new_cubes[key] = case neighbors(cubes_zyx, z, y, x).count(ACTIVE)
          when 2 then cubes_zyx[key]
          when 3 then ACTIVE
          else        INACTIVE
        end
      end
    end
  end
  new_cubes
end

def neighbors(cubes_zyx, z, y, x)
  ([-1, 0, 1].repeated_permutation(3).to_a - [[0,0,0]]).map do |zn, yn, xn|
    cubes_zyx[[z + zn, y + yn, x + xn]]
  end
end

6.times { cubes_zyx = cycle(cubes_zyx) }
puts cubes_zyx.values.count(ACTIVE)


