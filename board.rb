class Board
  def initialize(size = 10)
    @size = size
    @board = Array.new(@size) { Array.new(@size) }
  end

  def rand_place_ship(ship)
    ship_size = ship.type

    coord = get_place ship_size
    raise "An error has occurred. Ship can't be placed" if coord.nil?

    x, y = coord[:x], coord[:y]

    ship_size.times do
      @board[y][x] = ship_size
      coord[:dir] == 1 ? x += 1 : y += 1
    end
  end

  def print_board
    puts ('A'..'J').to_a.join(' ').insert(0, ' ' * 3)
    @board.each_with_index do |row, i|
      puts row.map{ |e| e || '.' }.join(' ').insert(0, (i + 1).to_s.ljust(3))
    end
  end

  private

  def get_place(size)
    allowable_coordinates = []

    @board.each_with_index do |y, yi|
      y.each_with_index do |x, xi|
        unless x
          check_free_space(xi, yi, size).each do |v|
            allowable_coordinates.push({ x: xi, y: yi, dir: v[:dir] })
          end
        end
      end
    end
    allowable_coordinates.sample
  end

  def check_free_space(x, y, size)
    out = []
    start_x = x == 0 ? x : x - 1
    start_y = y == 0 ? y : y - 1

    end_horizontal_x = end_point x, size
    end_horizontal_y = y + 1 == @size ? y : y + 1

    if end_horizontal_x
      arr = []
      (end_horizontal_y - start_y + 1).times do |c|
        arr << @board[start_y + c][start_x..end_horizontal_x]
      end
      out.push({x: start_x, y: start_y, dir: 1}) if arr.flatten.all? { |i| i.nil? }
    end

    end_vertical_y = end_point y, size
    end_vertical_x = x + 1 == @size ? x : x + 1

    if end_vertical_y
      arr = []
      (end_vertical_x - start_x + 1).times do |c|
        arr << @board.transpose[start_x + c][start_y..end_vertical_y]
      end
      out.push({x: start_x, y: start_y, dir: -1}) if arr.flatten.all? { |i| i.nil? }
    end
    out
  end

  def end_point(i, size)
    if i + size > @size
      nil
    elsif i + size == @size
      i + size - 1
    else
      i + size
    end
  end
end