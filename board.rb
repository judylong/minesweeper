require_relative 'tile.rb'

class Board
  NUMBER_OF_BOMBS = 9

  attr_accessor :grid

  def initialize
    @grid = Array.new(9) {Array.new(9)}
    place_tiles
    place_bombs
    update_all_tiles
  end

  def update_all_tiles
    grid.flatten.each { |tile| tile.update_neighbors }
  end

  def display
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        print self[[row_idx, col_idx]].to_s
      end
      print "\n"
    end
    return nil
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
        self[[row_idx,col_idx]] = Tile.new(self, [row_idx, col_idx])
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

  def over?(user_pick, action)
    blown_up?(user_pick, action) || all_revealed?
  end

  def blown_up?(user_pick, action)
    self[user_pick].bombed? && action == "reveal"
  end

  def all_revealed?
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        return false if !self[[row_idx, col_idx]].revealed?
      end
    end
    true
  end

  def perform_action(pos, action)
    if action == "flag"
      self[pos].toggle_flag
    elsif action == "reveal"
      self[pos].reveal
    else
      raise "enter valid action!"
    end
  end
end
