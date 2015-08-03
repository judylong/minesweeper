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
        self[[row_idx,col_idx]] = Tile.new
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

end
