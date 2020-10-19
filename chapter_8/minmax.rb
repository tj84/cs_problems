require_relative 'board.rb'

def minimax(board, maximising, original_player, max_depth = 8)
  # Base case - terminal position or maximum depth reached
  if board.is_win? || board.is_draw || max_depth == 0
    return board.evaluate(original_player)
  end
  # Recursive case - maximise your gains or minimise the opponent's gains
  if maximising
    best_eval = -Float::INFINITY
    board.legal_moves.each do |move|
      result = minimax(board.move(move), false, original_player, max_depth - 1)
      best_eval = [result, best_eval].max
    end
    return best_eval
  else
    worst_eval = Float::INFINITY
    board.legal_moves.each do |move|
      result = minimax(board.move(move), true, original_player, max_depth - 1)
      worst_eval = [result, worst_eval].min
    end
    return worst_eval
  end
end

def find_best_move(board, max_depth = 8)
  best_eval = -Float::INFINITY
  best_move = -1
  board.legal_moves.each do |move|
    result = alpha_beta(board.move(move), false, board.turn, max_depth)
    if result > best_eval
      best_eval = result
      best_move = move
    end
  end
  return best_move
end

def alpha_beta(board, maximizing, original_player, max_depth = 8, alpha = -Float::INFINITY, beta = Float::INFINITY)
  if board.is_win? || board.is_draw || max_depth == 0
    return board.evaluate(original_player)
  end
  if maximizing
    board.legal_moves.each do |move|
      result = alpha_beta(board.move(move), false, original_player, max_depth - 1, alpha, beta)
      alpha = [result, alpha].max
      if beta <= alpha
        break
      end
    end
    return alpha
  else
    board.legal_moves.each do |move|
      result = alpha_beta(board.move(move), true, original_player, max_depth - 1, alpha, beta)
      beta = [result, beta].min
      if beta <= alpha
        break
      end
    end
    return beta
  end
end
