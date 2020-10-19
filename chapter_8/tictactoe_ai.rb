require_relative 'minmax.rb'
require_relative 'tictactoe.rb'

def get_player_move(board)
  player_move = -1
  while !board.legal_moves.include?(player_move)
    puts "Enter a legal square (0-8):"
    player_move = gets.to_i
  end
  player_move
end

board = TTTBoard.new()
while true
  human_move = get_player_move(board)
  board = board.move(human_move)
  if board.is_win?
    puts "Human wins!"
    break
  elsif board.is_draw
    puts "Draw"
    break
  end
  computer_move = find_best_move(board)
  puts "computer move: #{computer_move}"
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
