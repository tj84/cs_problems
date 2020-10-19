class Piece
  def opposite
    raise "Need to implement opposite"
  end
end

class Board
  def turn
    raise "turn not implemented"
  end
  def move
    raise "move not implemented"
  end
  def legal_moves
    raise "legal_move not implemented"
  end
  def is_win?
    raise "is_win not implemented"
  end
  def is_draw
    return (!is_win? && legal_moves.length == 0)
  end
  def evaluate
    "evaluate is not implemented"
  end
end
