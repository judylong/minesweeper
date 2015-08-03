require_relative 'tile.rb'
require 'byebug'
class Board
  NUMBER_OF_BOMBS = 9

  attr_accessor :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
    setup_board
  end

  def setup_board
    place_tiles
    place_bombs
    update_tiles
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
    NEIGHBOR_TILES.each do |(dx, dy)|
      if (cur_x + dx).between?(0, 8) && (cur_y + dy).between?(0, 8)
        valid_tiles << self[[cur_x + dx, cur_y + dy]]
      end
    end
    valid_tiles
  end

  def update_tiles
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        self[[row_idx, col_idx]].neighbors = valid_tiles([row_idx, col_idx])
        update_bomb_count(self[[row_idx, col_idx]])
      end
    end
  end

  def update_bomb_count(tile)
    tile.neighbors.each do |neighbor|
      tile.neighbor_bomb_count += 1 if neighbor.bombed
    end
  end

  def over?(user_pick)
    blown_up?(user_pick) || all_revealed?
  end

  def blown_up?(user_pick)
    self[user_pick].bombed? && self[user_pick].revealed?
  end

  def all_revealed?
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        return false if !self[[row_idx, col_idx]].revealed?
      end
    end
    true
  end

end
