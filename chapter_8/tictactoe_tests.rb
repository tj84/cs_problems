require 'test/unit'
include Test::Unit::Assertions
require_relative 'tictactoe.rb'
require_relative 'minmax.rb'
require_relative 'tttpiece.rb'

class TTTMinimaxTestCase
  def test_easy_position
    to_win_easy_position = [TicTacPiece::X, TicTacPiece::O, TicTacPiece::X, 
                            TicTacPiece::X, TicTacPiece::E, TicTacPiece::O, 
                            TicTacPiece::E, TicTacPiece::E, TicTacPiece::O]
    test_board = TTTBoard.new(to_win_easy_position, TicTacPiece::X)
    answer = find_best_move(test_board)
    assert_equal(6, answer, "minimax did not find corrct next move")
  end

  def test_block_position
    to_block_position = [TicTacPiece::X, TicTacPiece::E, TicTacPiece::E,
                         TicTacPiece::E, TicTacPiece::E, TicTacPiece::O,
                         TicTacPiece::E, TicTacPiece::X, TicTacPiece::O]
    test_board = TTTBoard.new(to_block_position, TicTacPiece::X)
    answer = find_best_move(test_board)
    assert_equal(2, answer, "minimax did not block O from winning!")
  end

  def test_hard_position
    to_win_hard_position = [TicTacPiece::X, TicTacPiece::E, TicTacPiece::E,
                            TicTacPiece::E, TicTacPiece::E, TicTacPiece::O,
                            TicTacPiece::O, TicTacPiece::X, TicTacPiece::E]
    test_board = TTTBoard.new(to_win_hard_position, TicTacPiece::X)
    answer = find_best_move(test_board)
    assert_equal(1, answer, "minimax did not find the best move!")
  end
end

test = TTTMinimaxTestCase.new
test.test_easy_position
test.test_block_position
test.test_hard_position
