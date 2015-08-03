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


  def toggle_flag
    flagged? ? self.flagged = false : self.flagged = true
  end

  def inspect
    print "Tile: @flagged:#{flagged}; @revealed: #{revealed}; @bombed: #{bombed}; @position: #{position}"
  end

end
