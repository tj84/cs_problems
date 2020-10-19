require_relative 'board.rb'
require_relative 'tttpiece.rb'

class TTTpiece < Piece 
  attr_reader :piece
  def initialize(piece)
    @piece = piece
  end

  def opposite
    if @piece == TicTacPiece::X
      return TicTacPiece::O
    elsif @piece == TicTacPiece::O
      return TicTacPiece::X
    else
      return TicTacPiece::E
    end 
  end
end

class TTTBoard < Board
  attr_accessor :turn
  def initialize(position = Array.new(9, TicTacPiece::E), turn = TicTacPiece::X)
    @position = position 
    @turn = turn 
  end
  def turn
    return @turn
  end
  def deep_copy_position
    new_position = []
    @position.each do |element|
      new_position << element.clone
    end
    new_position
  end
  def move(location)
    temp_position = @position.map(&:clone) 
    temp_position[location] = @turn
    current_piece = TTTpiece.new(@turn)
    return TTTBoard.new(temp_position, current_piece.opposite)
  end
  def legal_moves
    moves = []
    @position.each_with_index do |position, index|
      if position == TicTacPiece::E
        moves << index
      end
    end
    moves
  end
  def is_win?
    #three rows, three columns and three diagonal checks
    return @position[0] == @position[1] &&
           @position[0] == @position[2] &&
           @position[0] != TicTacPiece::E ||
           @position[3] == @position[4] &&
           @position[3] == @position[5] &&
           @position[3] != TicTacPiece::E ||
           @position[6] == @position[7] &&
           @position[6] == @position[8] &&
           @position[6] != TicTacPiece::E ||
           @position[0] == @position[3] &&
           @position[0] == @position[6] &&
           @position[0] != TicTacPiece::E ||
           @position[1] == @position[4] &&
           @position[1] == @position[7] &&
           @position[1] != TicTacPiece::E ||
           @position[2] == @position[5] &&
           @position[2] == @position[8] &&
           @position[2] != TicTacPiece::E ||
           @position[0] == @position[4] &&
           @position[0] == @position[8] &&
           @position[0] != TicTacPiece::E ||
           @position[2] == @position[4] &&
           @position[2] == @position[6] &&
           @position[2] != TicTacPiece::E
  end
  def evaluate(player)
    if self.is_win? && @turn == player
      return -1
    elsif self.is_win? && @turn != player
      return 1
    else
      return 0
    end
  end
  def to_s
    "#{@position[0]} | #{@position[1]} | #{@position[2]} \n
-------- \n
#{@position[3]} | #{@position[4]} | #{@position[5]} \n
-------- \n
#{@position[6]} | #{@position[7]} | #{@position[8]}"
  end
end
