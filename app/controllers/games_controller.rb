require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split(" ")
    @array = params[:word].upcase.split("").to_a
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    if @array.each { |letter| @letters.include?(letter) } && json['found'] == true
      @score = "Congratulations #{params[:word].upcase} is a valid English word #{@letters.to_s}!"
    elsif json['found'] == false || @array.each { |letter| @letters.include?(letter) }
      @score = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    else
      @score = "Sorry but #{params[:word].upcase} can't be built out of #{@letters.to_s}"
    end
  end
end
