require_relative 'words_provider'

class HangmanGame
  STARTING_LIVES = 8

  def initialize(word = nil)
    @word = word || WordsProvider.new.random_word
    @remaining_lives = STARTING_LIVES
    @current_guess = "*" * @word.length
    @game_in_progress = true
  end

  def play
    loop do
      current_guess = ask_for_guess
      guessed_positions = find_guessed_positions(current_guess)

      if guessed_positions.length > 0 
        guessed_positions.each { |position| @current_guess[position] = current_guess }
        puts "Excellent, shall we try another one?" unless won?
      else
        @remaining_lives -= 1 
        puts "Yay, shall we try another one?" unless lost?
      end

      break if lost? || won?
    end
    
    puts lost? ? "Oh mine, oh mine oh mine. Your spelling teacher hung himself! This extremelly difficult word was #{@word}."
               : "Marvellously done, sir!"
  end

  
  private

  def lost?
    @remaining_lives < 1
  end

  def won?
    !@current_guess.include?('*')
  end

  def find_guessed_positions(guess)
    @word.length.times.find_all { |i| @word[i] == guess } 
  end 

  def ask_for_guess
    puts "#{@current_guess} and only #{@remaining_lives} lives remain. Now it's time to show your best!"
    guess = gets.chomp
    
    if guess.length == 1 
      guess
    else
      puts "Oh man, why did you enter this? It's not even a single character."
      ask_for_guess
    end
  end
end