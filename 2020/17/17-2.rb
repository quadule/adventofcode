ACTIVE = '#'
INACTIVE = '.'
lines = File.read("input.txt").lines
cubes_zyxw = Hash.new { INACTIVE }

lines.each.with_index do |line, y|
  line.scan(/./).each.with_index do |cube, x|
    cubes_zyxw[[0, y, x, 0]] = cube
  end
end;

def putcubes(cubes_zyxw)
  min_z, max_z = cubes_zyxw.keys.map { |(z, y, x, w)| z }.minmax
  min_y, max_y = cubes_zyxw.keys.map { |(z, y, x, w)| y }.minmax
  min_x, max_x = cubes_zyxw.keys.map { |(z, y, x, w)| x }.minmax
  min_w, max_w = cubes_zyxw.keys.map { |(z, y, x, w)| w }.minmax
  min_z.upto(max_z) do |z|
    min_w.upto(max_w).each do |w|
      puts "\nz=#{z}, w=#{w}"
      min_y.upto(max_y).each do |y|
        min_x.upto(max_x).each do |x|
          print cubes_zyxw[[z, y, x, w]]
        end
        puts
      end
    end
  end
  nil
end

# putcubes cubes_zyxw

def cycle(cubes_zyxw)
  new_cubes = cubes_zyxw.dup
  min_z, max_z = cubes_zyxw.keys.map { |(z, y, x, w)| z }.minmax
  min_y, max_y = cubes_zyxw.keys.map { |(z, y, x, w)| y }.minmax
  min_x, max_x = cubes_zyxw.keys.map { |(z, y, x, w)| x }.minmax
  min_w, max_w = cubes_zyxw.keys.map { |(z, y, x, w)| w }.minmax
  (min_z - 1).upto(max_z + 1) do |z|
    (min_y - 1).upto(max_y + 1) do |y|
      (min_x - 1).upto(max_x + 1) do |x|
        (min_w - 1).upto(max_w + 1) do |w|
          key = [z, y, x, w]
          new_cubes[key] = case neighbors(cubes_zyxw, z, y, x, w).count(ACTIVE)
            when 2 then cubes_zyxw[key]
            when 3 then ACTIVE
            else        INACTIVE
          end
        end
      end
    end
  end
  new_cubes
end

def neighbors(cubes_zyxw, z, y, x, w)
  ([-1, 0, 1].repeated_permutation(4).to_a - [[0,0,0,0]]).map do |zn, yn, xn, wn|
    cubes_zyxw[[z + zn, y + yn, x + xn, w + wn]]
  end
end

6.times { cubes_zyxw = cycle(cubes_zyxw) }
# putcubes cubes_zyxw
puts cubes_zyxw.values.count(ACTIVE)


