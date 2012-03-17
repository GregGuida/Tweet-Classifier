class Tweet < ActiveRecord::Base

  URL_REGEX = /(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/i

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
end
