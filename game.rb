require_relative 'board.rb'
require_relative 'tile.rb'

class Game

  attr_accessor :board, :current_action, :current_position

  def initialize(board=Board.new)
    @board = board
    @current_action = nil
    @current_position = nil
  end

  def play
    prompt
    until board.over?(current_position)
      board.perform_action(current_position, current_action)
      prompt
    end
  end

  def prompt
    puts "Pick a position and an action (e.g. [0,0] flag)"
    input = gets.chomp
    position_string, self.current_action = input.split(" ")
    self.current_position = position_string[1...-1].split(",").map(&:to_i)
  end

end
