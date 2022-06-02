class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'...'Z').to_a.sample }
    @answer = params[:score]
  end

  def score
    new
    require "json"
    require "open-uri"
    url = "https://wagon-dictionary.herokuapp.com/#{params[:score]}"
    open_url = URI.open(url).read
    @parsed_data = JSON.parse(open_url)
    @grid_check_array = []

    @parsed_data["found"] ? @message1 = "Congrats your answer (#{@answer}) was an english word" : @message1 = "(#{@answer}) is not an english word"

    params[:score].upcase.chars.each do |letter|
      if !@letters.include?(letter)
        @message2 = "#{letter} not in the grid"
      else
        @message2 = "Congrats your answer (#{@answer}) was within the grid"
      end
    end
  end
end
