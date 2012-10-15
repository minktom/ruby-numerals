class ConverterController < ApplicationController

  def index
  end

  def phrase
    if params[:number]
      @number = params[:number].to_i
      @english_phrase = EnglishPhrase.new( @number ).to_s
    end
  end

end
