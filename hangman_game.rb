require_relative 'words_provider'

class HangmanGame
  STARTING_LIFES = 8

  def initialize(word = nil)
    @word = WordsProvider.new.random_word if word.nil? or word.empty?
    @remaining_lives = STARTING_LIFES
    @current_guess = "*" * @word.length
  end

  def play!
    was_successful = evaluate_guess?(ask_for_guess)
    @remaining_lives -= 1 unless was_successful

    if @remaining_lives < 1
      puts "Oh mine, oh mine oh mine. Your spelling teacher hung himself! This extremelly difficult word was #{@word}."  
    elsif not @current_guess.include?('*')
      puts "Marvellously done, sir!"
    else
      puts was_successful ? "Excellent, shall we try another one?" : "Yay, shal we try another one?"
      play!
    end
  end

  
  private

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

  def evaluate_guess?(guess)
    successful_guess = false
    @word.split("").each_with_index do |current_char, index|
      if current_char == guess
        @current_guess[index] = current_char 
        successful_guess = true
      end 
    end
    successful_guess
  end 

end