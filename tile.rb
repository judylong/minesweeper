class Tile
  attr_accessor :revealed, :bombed, :flagged

  def initialize(bombed = false)
    @revealed = false
    @flagged = false
    @bombed = bombed
  end

end
