require 'open-uri'
require 'json'
class GamesController < ApplicationController
  
  def score
    @letters = params[:letters]
    @word = params[:word]
    @score = if included?(@word, @letters)
              if english_word?(@word)
                "Well done #{word} is a valid word!"
              else
                "Not an English word"
              end
            else 
              'not in the grid'
            end
  end
  
  def new
    @letters = []
    10.times do 
     @letters << ('a'..'z').to_a.sample
    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  
  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
