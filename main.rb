load 'ship.rb'
load 'board.rb'

MAX_SHIP_SIZE = 4

board = Board.new

count = 1
MAX_SHIP_SIZE.downto(1) do |k|
  count.times do
    board.rand_place_ship Ship.new k
  end
  count += 1
end

board.print_board