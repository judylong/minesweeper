require_relative 'board.rb'
require_relative 'tile.rb'

class Game

  attr_accessor :board

  def initialize(board=Board.new)
    @board = board
  end

  def play

  end

  def prompt
    puts "Pick a position and an action (e.g. [0,0] flag)"
    input = gets.chomp
    position_string, action = input.split(" ")

    position_string[1...-1].split(",").map(&:to_i)
  end
  
end
