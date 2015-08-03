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
    # self.revealed = true
    queue = [self]
    # p self
    until queue.empty?
      current = queue.shift
      p current
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

  def toggle_flag
    flagged? ? self.flagged = false : self.flagged = true
  end

  def inspect
    print "Tile: @flagged:#{flagged}; @revealed: #{revealed}; @bombed: #{bombed}; @position: #{position}"
  end

end
