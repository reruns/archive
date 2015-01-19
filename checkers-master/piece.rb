class Piece
  #Positions on a grid are more naturally expressed as vectors.
  #Mainly, it makes it much nicer whenever we need to do math with them.
  DELTAS = [Vector[1,-1], Vector[1,1], Vector[-1,1], Vector[-1,-1]]

  def initialize(board, pos, color, king = false)
    @board = board
    @pos = Vector::elements(pos)
    @king = king
    @color = color
    @board.move_piece(@pos, self)
  end

  def pos=(loc)
    @pos = Vector::elements(loc)
  end

  attr_reader :color, :pos, :king

  def render
    str = @king ? "◉" : "●"
    str.colorize(color)
  end

  #This is only used in calculating win conditions so we can have an easier
  #time performing jumps.
  def valid_moves
    (slide_moves + jump_moves).select { |move| valid_move_seq?([move]) }
  end

  def perform_moves(sequence)
    raise InvalidMoveError.new("Bad Move") unless valid_move_seq?(sequence.dup)
    perform_moves!(sequence)
  end

  protected
  def valid_move_seq?(sequence)
    @board.dup[pos].perform_moves!(sequence)
  end

  def perform_moves!(sequence)
    if sequence.count == 1
      return false unless perform_slide(sequence[0]) ||
                          perform_jump(sequence[0])
    else
      until sequence.empty?
        return false unless perform_jump(sequence.shift)
      end
    end
    true
  end

  private
  def slide_moves
    direction = color == COLORS[:player2] ? 1 : -1
    delts = king ? DELTAS : DELTAS.take(2)

    slide_moves = []

    delts.each do |delta|
      d = Vector::elements(delta)
      slide_moves << (pos + d * direction).to_a
    end
    slide_moves
  end

  def jump_moves
    direction = color == COLORS[:player2] ? 1 : -1
    delts = king ? DELTAS : DELTAS.take(2)

    jump_moves = []

    delts.each do |delta|
      d = Vector::elements(delta)
      jump_moves << (pos + d * 2 * direction).to_a
    end

    jump_moves
  end


  def perform_slide(loc)
    return false unless onboard?(loc)
    moves = slide_moves

    return false unless moves.include?(loc) && @board[loc].nil?
    @board.move_piece(loc,self)
    maybe_promote
    true
  end

  #all these return falses bug me
  def perform_jump(loc)
    return false unless onboard?(loc)

    moves = jump_moves
    return false unless moves.include?(loc)

    jump = slide_moves[moves.index(loc)]
    return false unless @board[loc].nil? && !@board[jump].nil?

    @board.move_piece(jump, nil)
    @board.move_piece(loc, self)

    maybe_promote
    true
  end

  def onboard?(loc)
    loc.all? { |x| x.between?(0, WIDTH-1) }
  end

  def maybe_promote
    @king = true if pos[0] == WIDTH-1 || pos[0] == 0
  end
end
