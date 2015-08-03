require_relative 'board.rb'
require_relative 'tile.rb'

class Game

  attr_accessor :board, :current_action, :current_position

  def initialize(board = Board.new)
    @board = board
    @current_action = nil
    @current_position = nil
  end

  def play
    board.display
    prompt
    until board.over?(current_position, current_action)
      board.perform_action(current_position, current_action)
      board.display
      prompt
    end
    board.display
  end

  def prompt
    puts "Pick a position and an action (e.g. [0,0] flag)"
    input = gets.chomp
    position_string, self.current_action = input.split(" ")
    self.current_position = position_string[1...-1].split(",").map(&:to_i)
  end

end
