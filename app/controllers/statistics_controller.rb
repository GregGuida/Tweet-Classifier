class StatisticsController < ApplicationController
  def index
  	@tweets = Tweet.find(:all,:select=>"username, sentiment, count(id) as count",:group=>"sentiment,username", :order => "username")

  	# filter out null users and give me tweets grouped by sentiment
  	@sentiment_groups = @tweets.select{|t| t.username != 'null'}.group_by{|t| t.sentiment }
  	# reduce the hash so each key points to a total of all its values
  	@sentiment_groups.each{|k,v| @sentiment_groups[k] = v.reduce(0){|m,t| m+t.count.to_i}}

  	@sentiment_values = { -1 => "Unsure", 0 => "Negative", 1 => "Positive" }
  end
end
