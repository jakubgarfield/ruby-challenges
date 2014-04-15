# First of the ruby day challenges
# This is the game that generates a random number between 1 and 1000
# and lets the user guess 8 times and giving him the answer whether
# the guess was correct, too high or too low.

class GuessNumberGame
  
  RESULT_LOWER_BOUND = 1
  RESULT_UPPER_BOUND = 1000
  NUMBER_OF_GUESSES = 8

  def play
    wanted = generate_number

    for i in 1..NUMBER_OF_GUESSES
      current = guess()
      if current ==  wanted 
        puts "Excellent sir, very well done!"
        break
      elsif current < wanted
        puts "No, no, no, no, no. The number is larger than that."
      else
        puts "Yay, this is way too much."
      end
    end
  end
  
  def generate_number
    rand(RESULT_LOWER_BOUND..RESULT_UPPER_BOUND)
  end

  def guess
    puts "Try to guess a number between #{RESULT_LOWER_BOUND} and #{RESULT_UPPER_BOUND}"
    gets.chomp.to_i
  end
end

GuessNumberGame.new.play
