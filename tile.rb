class Tile
  attr_accessor :revealed

  def initialize(bombed = false)
    @revealed = false
    @flagged = false
    @bombed = bombed
  end

end
