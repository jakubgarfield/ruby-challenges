require 'open-uri'

class WordsProvider
  DATABASE_URL = "http://seriousorange.com/words.txt"
  DATABASE_PATH = "words.txt"

  def random_word
    ensure_database
    all_words.sample
  end

  def all_words
    ensure_database
    File.read(DATABASE_PATH).split
  end


  private 
  def ensure_database
      File.write(DATABASE_PATH, open(DATABASE_URL).read) unless File.exist?(DATABASE_PATH)
  end
end