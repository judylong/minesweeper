require_relative 'board.rb'
class Tile

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

  attr_accessor :revealed, :bombed, :flagged, :neighbors,
                :neighbor_bomb_count, :position, :board

  def initialize(board, position, bombed = false)
    @revealed = false
    @flagged = false
    @bombed = bombed
    @neighbors = []
    @neighbor_bomb_count = 0
    @position = position
    @board = board
  end

  def bombed?
    bombed
  end

  def flagged?
    flagged
  end

  def revealed?
    revealed
  end

  def reveal
    # self.revealed = true
    queue = [self]
    until queue.empty?
      current = queue.shift
      if current.neighbor_bomb_count == 0
        current.neighbors.each do |neighbor|
          if !neighbor.revealed?
            queue << neighbor
          end
        end
      end
      current.revealed = true
    end

  end

  def to_s
    if !self.revealed? && !self.flagged?
      "*"
    elsif !self.revealed? && self.flagged?
      "F"
    elsif self.revealed? && self.bombed?
      "B"
    elsif self.revealed? && self.neighbor_bomb_count > 0
      "#{self.neighbor_bomb_count}"
    elsif self.revealed? && self.neighbor_bomb_count == 0 && !self.bombed?
      "_"
    end
  end

  def valid_tiles
    valid_tiles = []
    cur_x, cur_y = self.position
    NEIGHBOR_TILES.each do |(dx, dy)|
      if (cur_x + dx).between?(0, 8) && (cur_y + dy).between?(0, 8)
        valid_tiles << board[[cur_x + dx, cur_y + dy]]
      end
    end
    valid_tiles
  end

  def update_neighbors
      self.neighbors = self.valid_tiles
      self.update_bomb_count
  end

  def update_bomb_count
    self.neighbors.each do |neighbor|
      self.neighbor_bomb_count += 1 if neighbor.bombed?
    end
  end

  def toggle_flag
    flagged? ? self.flagged = false : self.flagged = true
  end

  def inspect
    print "Tile: @flagged:#{flagged}; @revealed: #{revealed}; @bombed: #{bombed}; @position: #{position}"
  end

end
