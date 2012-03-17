class Tweet < ActiveRecord::Base

	def self.sanitize ( text )
		url_regex = /(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))/i
		result = ""

		#Remove URLs
		result = text.gsub(url_regex,' ')
		#Remove handles
		result = result.gsub(/@\w*/,' ')
		#remove hash from Hashtags
		result = result.gsub('#',' ')
		#replace . , ! ? $ with ' ' \n
		result = result.gsub(/\.|,|!|\?|\^|\$|\*|\+|=|%|~|\n/,' ')
		#remove digits
		result = result.gsub(/\s\d+\s/,' ')

		return result
	end

end
