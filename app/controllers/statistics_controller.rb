class StatisticsController < ApplicationController
  def index
  	@tweets = Tweet.find(:all,:select=>"username, sentiment, count(id) as count",:group=>"sentiment,username", :order => "username")
  	@sentiment_values = { -1 => "Unsure", 0 => "Negative", 1 => "Positive" }
  end
end
