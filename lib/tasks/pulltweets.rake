task :pulltweets => :environment do
	require 'net/http'
	require 'json'

	uri = URI('https://stream.twitter.com/1/statuses/sample.json')
	numtweets = 0

	Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	  request = Net::HTTP::Get.new uri.request_uri
	  request.basic_auth 'whochirp', 'ichirpyouchirp'

	  http.request request do |response|
	    response.read_body do |chunk|
	    	break unless numtweets < 10
	    	tweet = JSON.parse(chunk)
	    	next unless tweet['user']['lang'] == 'en'
	    	numtweets += 1
	    	#puts tweet['id']
	    	#puts tweet['text']
	    	Tweet.create(:tid => tweet['id'], :text => tweet['text'])
	    end
	    break
	  end
	end
end