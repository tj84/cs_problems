require_relative 'minmax.rb'
require_relative 'connectfour.rb'

def get_player_move(board)
  player_move = -1
  while !board.legal_moves.include?(player_move) 
    puts "Enter a legal column (0-6):"
    player_move = gets.to_i
  end
 player_move 
end

board = C4Board.new 
puts "legal moves: #{board.legal_moves}"
while true
  human_move = get_player_move(board)
  #human_move = find_best_move(board, 5)
  board = board.move(human_move)
  if board.is_win?
    puts "Human wins!"
    break
  elsif board.is_draw
    puts "Draw!"
    break
  end
  computer_move = find_best_move(board, 5)
  puts "Computer move: #{computer_move}"
  board = board.move(computer_move)
  puts board
  if board.is_win?
    puts "Computer wins!"
    break
  elsif board.is_draw
    puts "Draw!"
    break
  end
end
