require "open-uri"

class Word < ApplicationRecord
  validates :word, presence: true

  def valid_english_word?
    url = "https://api.dictionaryapi.dev/api/v2/entries/en/#{@definition}"
    dictionary_entry = JSON.parse(URI.parse(url).read)
    word = dictionary_entry.first["word"]
    word.nil? ? false : true
  end
end
