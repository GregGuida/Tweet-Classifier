require "csv"
class Tweet < ActiveRecord::Base

  URL_REGEX = /(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/i
  SENTIMENTS = {-1 => 'unknown', 0=>'neg', 1=>'pos'}

  def self.sanitize ( text )
    #Remove URLs
    #Remove handles
    #remove hash from Hashtags
    #replace . , ! ? $ with ' ' \n
    #remove digits
    # remove leading / trailing space
    text.gsub(Tweet::URL_REGEX, ' ')
    .gsub(/@\w*/,' ')
    .gsub('#',' ')
    .gsub(/\.|,|!|\?|\^|\$|\*|\+|=|%|~|\n/,' ')
    .gsub(/\s\d+\s/,' ')
    .strip
  end

  def self.create_csv ( tweets )
    CSV.generate { |csv| tweets.each{ |t| csv << [t.text, SENTIMENTS[t.sentiment] ] } }
  end
end
