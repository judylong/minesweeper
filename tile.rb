class Tile
  attr_accessor :revealed, :bombed, :flagged

  def initialize(bombed = false)
    @revealed = false
    @flagged = false
    @bombed = bombed
    @neighbors = []
    @neighbor_bomb_count = 0
  end

end
