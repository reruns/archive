#encoding: UTF-8
require 'matrix'
require 'colorize'
require 'yaml'
require './board'
require './piece'

COLORS = {
    :player1 => :red,
    :player2 => :black,
    :light => :default,
    :dark => :light_black,
    :border => :light_white,
    :highlight => :light_green
}

class Game
  def initialize(p1, p2)
    @players = [p1.new(COLORS[:player1]),p2.new(COLORS[:player2])]
    @board = Board.new
  end

  def play
    @board.display

    until @board.winner?(COLORS[:player1]) || @board.winner?(COLORS[:player2])

      begin
        move = @players.first.get_move(@board)

        if move == "save"
          save_game
          return
        end

        @board.display(move)
      rescue InvalidMoveError => e
        @board.display
        puts e.message
        retry
      end

      @players.rotate!
    end

    puts "Well played! #{@players[1].color.to_s.capitalize} is the winner!"
  end

  private

  def save_game
    puts "Enter a filename to save to: "
    fnam = gets.chomp.split('.sav')[0]
    f = File.open(fnam + '.sav','w') { |f| f.puts self.to_yaml }
  end

end

class InvalidMoveError < StandardError
end

class HumanPlayer
  def initialize(color)
    @color = color
  end

  attr_reader :color

  def get_move(board)
    puts "#{@color}, enter a move"
    input = gets.chomp.split(' ')
    return "save" if input[0] == "save"

    coords = input.map { |coord| translate_loc(coord) }
    move = coords.dup
    piece = board[coords.shift]
    if piece.nil? || piece.color != @color
      raise InvalidMoveError.new("No movable piece there.")
    end

    piece.perform_moves(coords)
    move
  end

  private

  def translate_loc(loc)
    y = loc[0].bytes[0] - 97
    x = WIDTH - loc[1...loc.length].to_i
    [x,y]
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.count == 0
    g = Game.new(HumanPlayer, HumanPlayer)
  else
    fnam = ARGV.shift
    g = YAML::load(File.read(fnam))
  end

  g.play
end
