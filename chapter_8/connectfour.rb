require_relative 'board.rb'
require_relative 'c4piece.rb'

class C4Piece < Piece
  attr_reader :piece
  def initialize(piece)
    @piece = piece
  end
  def opposite
    if @piece == Connect4Piece::B
      return Connect4Piece::R
    elsif @piece == Connect4Piece::R
      return Connect4Piece::B
    else
      return Connect4Piece::E
    end
  end
end

class C4Board < Board
  attr_reader :segments
  def initialize(position = nil, turn = Connect4Piece::B)
    @num_rows = 6
    @num_columns = 7
    @segment_length = 4
    @segments = generate_segments
    @position = position
    @turn = turn 
    if @position == nil
      @position = []
      @num_columns.times do |i|
        @position << C4Board::Column.new()
      end
    end
  end

  def turn
    @turn
  end
  def move(location)
    temp_position = []
    @num_columns.times do |col|
      temp_position << @position[col].copy
    end 
    temp_position[location].push(@turn)
    current_piece = C4Piece.new(@turn) 
  return  C4Board.new(temp_position, current_piece.opposite)
  end
  def legal_moves
    moves = []
    @num_columns.times do |c|
      if !@position[c].full
        moves << c 
      end
    end
    moves
  end
  def count_segment(segment)
    @black_count = 0
    @red_count = 0
    segment.each do |seg|
      row = seg[1]
      col = seg[0]
      if @position[col].container[row] == Connect4Piece::B
        @black_count += 1
      elsif @position[col].container[row] == Connect4Piece::R
        @red_count += 1
      end 
    end
  end
  def is_win?
    @segments.each do |segment|
      count_segment(segment)
      if @black_count == 4 || @red_count == 4
        return true
      end
    end
    false
  end
  def evaluate_segment(segment, player)
    count_segment(segment)
    if @red_count > 0 && @black_count > 0
      return 0 # mixed segment
    end
    count = [@red_count, @black_count].max
    score = 0
    if count == 2
      score = 1
    elsif count == 3
      score = 100
    elsif count == 4
      score = 1000000
    end
    color = Connect4Piece::B
    if @red_count > @black_count
      color = Connect4Piece::R 
    end 
    if color != player 
      return -score
    end
    score
  end
  def evaluate(player)
    total = 0
    @segments.each do |segment|
      total += evaluate_segment(segment, player)
    end
    total
  end
  def to_s
    display = ""
    (0...@num_rows).reverse_each do |r|
      display += "|"
      @num_columns.times do |c|
        if @position[c].container[r].to_s != "B" && @position[c].container[r].to_s != "R" 
          display += " |"
        else
         display += "#{@position[c].container[r]}|"
        end
      end
      display += "\n"
    end
    display
  end

  class Column
    attr_accessor :container
    attr_reader :max_elements
    def initialize(num_rows = 6)
      @container = []
      @max_elements = num_rows
    end
    def full
      @container.length == @max_elements
    end
    def push(item)
      if full
        raise "Trying to push piece to full column"
      end
      @container.append(item)
    end
    def get_item(index)
      if index > @container.length - 1
        return Connect4Piece::E
      end
      @container[index]
    end
    def to_s
      "#{@container}"
    end
    def copy
      temp = C4Board::Column.new()
      temp.container = @container.clone
      temp
    end
  end

 private
  def generate_segments
    segments = []
    @num_columns.times do |c|
      (@num_rows - @segment_length + 1).times do |r|
        segment = []
        @segment_length.times do |t|
          segment.append([c, r + t])
        end
        segments.append(segment)
      end
    end
    (@num_columns - @segment_length + 1).times do |c|
      @num_rows.times do |r|
        segment = []
        @segment_length.times do |t|
          segment.append([c + t, r])
        end 
        segments.append(segment)
      end
    end
    (@num_columns - @segment_length + 1).times do |c|
      (@num_rows - @segment_length + 1).times do |r|
        segment = []
        @segment_length.times do |t|
          segment.append([c + t, r + t])
        end
        segments.append(segment)
      end
    end
    (@num_columns - @segment_length + 1).times do |c|
      (@segment_length - 1..@num_rows).each do |r|
        segment = []
        @segment_length.times do |t|
          segment.append([c + t, r - t])
        end
        segments.append(segment)
      end
    end
    segments
  end
end

