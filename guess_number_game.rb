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

    NUMBER_OF_GUESSES.times do
      current_guess = ask_for_guess
      if current_guess ==  wanted 
        puts "Excellent sir, very well done!"
        break
      elsif current_guess < wanted
        puts "No, no, no, no, no. The number is larger than that."
      else
        puts "Yay, this is way too much."
      end
    end
  end
  
  def generate_number
    rand(RESULT_LOWER_BOUND..RESULT_UPPER_BOUND)
  end

  def ask_for_guess
    puts "Try to guess a number between #{RESULT_LOWER_BOUND} and #{RESULT_UPPER_BOUND}"
    gets.chomp.to_i
  end
end

GuessNumberGame.new.play

# Lessons learned
# 1) Use long descriptive name
# 2) Almost never rescue/catch exception (dynamic language)
# 3) Never use for, use X.times instead or 1..X.eacha
# 4) VIM - df. - deletes everything until the first occurence of .
