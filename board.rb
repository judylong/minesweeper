require_relative 'tile.rb'

class Board
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
        self[[row_idx,col_idx]] = Tile.new
      end
    end
  end

end
