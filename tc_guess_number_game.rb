require_relative "guess_number_game"
require "test/unit"

class TestGuessNumberGame < Test::Unit::TestCase
  
  def test_number_generation
    result = GuessNumberGame.new.generate_number
    assert(result < GuessNumberGame::RESULT_UPPER_BOUND)
    assert(result > GuessNumberGame::RESULT_LOWER_BOUND)
  end



end
