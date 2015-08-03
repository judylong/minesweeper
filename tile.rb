class Tile
  attr_accessor :revealed, :bombed, :flagged, :neighbors,
                :neighbor_bomb_count, :position

  def initialize(position, bombed = false)
    @revealed = false
    @flagged = false
    @bombed = bombed
    @neighbors = []
    @neighbor_bomb_count = 0
    @position = position
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
    self.revealed = true
  end

  def toggle_flag
    flagged? ? self.flagged = false : self.flagged = true
  end

end
