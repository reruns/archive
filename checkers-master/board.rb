WIDTH = 8

class Board
  def initialize(setup_board = true)
    @grid = Array.new(WIDTH) { Array.new(WIDTH) }
    if setup_board
      setup_mans(0, COLORS[:player2])
      setup_mans(WIDTH-3, COLORS[:player1])
    end
  end

  def winner?(color)
    enemy = color == COLORS[:player1] ? COLORS[:player2] : COLORS[:player1]
    enemies = pieces(enemy)
    enemies.empty? || enemies.all? { |enemy| enemy.valid_moves.empty? }
  end

  def pieces(color)
    pieces = @grid.flatten.compact
    return pieces if color == :both
    pieces.select { |piece| piece.color == color }
  end

  def dup
    board_copy = Board.new(false)

    pieces(:both).each do |piece|
      Piece.new(board_copy, piece.pos, piece.color, piece.king)
    end
    board_copy
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end

  def move_piece(pos, piece)
    if piece
      loc = piece.pos
      piece.pos = pos
      @grid[loc[0]][loc[1]] = nil
    end
    self[[pos[0],pos[1]]] = piece
  end

  #Don't feed I/O methods after midnight
  def display(move = [])
    cls

    bg1 = COLORS[:light]
    bg2 = COLORS[:dark]
    border = COLORS[:border]

    top_bot_border = "    #{('A'..'Z').to_a.take(WIDTH).join('  ')}    "
                     .colorize(:background => border)
    puts top_bot_border

    color = bg1

    @grid.each_with_index do |row, idx|
      print "#{' ' if WIDTH - idx < 10}#{WIDTH - idx} ".
            colorize(:background => border)

      row.each_with_index do |space, space_idx|
        back = move.include?([idx, space_idx]) ? COLORS[:highlight] : color

        if space.nil?
          print "   ".colorize(:background => back)
        else
          print " #{space.render} ".colorize(:background => back)
        end
        color = color == bg1 ? bg2 : bg1
      end
      color = color == bg1 ? bg2 : bg1 unless WIDTH.odd?
      print " #{WIDTH - idx}#{' ' if WIDTH - idx < 10}\n".
            colorize(:background => border)
    end
    puts top_bot_border
    nil
  end

  private
  #Why are pieces in checkers called men?
  def setup_mans(row,color)
    3.times do
      @grid[row].each_index do |col|
        Piece.new(self, [row,col], color) if (row+col).odd?
      end
      row += 1
    end
  end

  def cls
    system "clear" or system "cls"
  end
end
