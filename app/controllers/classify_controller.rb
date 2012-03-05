class ClassifyController < ApplicationController
  def index
  	@tweet = Tweet.where(:username => 'null').first
  end
end
