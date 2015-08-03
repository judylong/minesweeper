require_relative 'board.rb'
require_relative 'tile.rb'

class Game

  attr_accessor :board

  def initialize(board)
    @board = board

  end
end
