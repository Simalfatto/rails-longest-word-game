require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letter].split(' ').to_a
    characters = @word.upcase.chars
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = URI.open(url).read
    found = JSON.parse(response)['found']
    if !(characters - @letters).empty?
      @answer = "Sorry but <b>#{@word.upcase}</b> can't be built over #{@letters}".html_safe
    elsif found == false
      @answer = "Sorry but <b>#{@word.upcase}</b> doesn't seem to be an English word".html_safe
    else
      @answer = "Congratulations! <b>#{@word.upcase}</b> is a valid English word".html_safe
    end
  end
end
