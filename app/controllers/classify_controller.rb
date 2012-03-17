class ClassifyController < ApplicationController
  def index
    @tweet = Tweet.where(:username => 'null').first
    redirect_to statistics_path unless @tweet
  end
end
