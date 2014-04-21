require 'open-uri'

class WordsProvider
  DATABASE_URL = "http://seriousorange.com/words.txt"
  DATABASE_PATH = "words.txt"

  def random_word
    ensure_database
  
    words = all_words
    words[rand(0..words.length)]
  end

  def all_words
    ensure_database

    open(DATABASE_PATH, 'r') do |file|
      file.readlines.map { |i| i.chomp }
    end
  end


  private 
  def ensure_database
    unless File.exist?(DATABASE_PATH) 
      open(DATABASE_PATH, 'w') do |file|
        file << open(DATABASE_URL).read
      end
    end
  end

end