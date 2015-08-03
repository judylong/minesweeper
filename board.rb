require_relative 'tile.rb'

class Board
  NUMBER_OF_BOMBS = 9

  attr_accessor :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, tile)
    x, y = pos
    self.grid[x][y] = tile
  end

  def place_tiles
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        self[[row_idx,col_idx]] = Tile.new([row_idx, col_idx])
      end
    end
  end

  def place_bombs
    bombs_placed = 0
    until bombs_placed == NUMBER_OF_BOMBS do
      row = rand(0...9)
      col = rand (0...9)
      if self[[row,col]].bombed == false
         self[[row,col]].bombed = true
         bombs_placed += 1
      end
    end
  end

  NEIGHBOR_TILES = [
  [-1, 0],
  [-1,  1],
  [0, 1],
  [1,  1],
  [ 1, 0],
  [ 1,  -1],
  [ 0, -1],
  [ -1,  -1]
]

def valid_tiles(pos)
  valid_tiles = []

  cur_x, cur_y = pos
  p pos
  p cur_x
  p cur_y
  NEIGHBOR_TILES.each do |(dx, dy)|
    updated_x, updated_y = (cur_x + dx), (cur_y + dy)
    p self[[updated_x, updated_y]]
    new_tile = self[[cur_x + dx, cur_y + dy]]

    if new_tile.position.all? { |coord| coord.between?(0, 7) }
      valid_tiles << new_tile
    end
  end

  valid_tiles
end
  # def update_tiles
  #   grid.each_with_index do |row, row_idx|
  #     row.each_with_index do |col, col_idx|
  #       # this specific @ row_idx, col_idx update_neighbors
  #     end
  #   end
  # end

end
