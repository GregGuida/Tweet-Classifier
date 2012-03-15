desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour == 0 # run at midnight
    require 'net/http'
	require 'json'

	uri = URI('https://stream.twitter.com/1/statuses/sample.json')
	numtweets = 0

	Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	  request = Net::HTTP::Get.new uri.request_uri
	  request.basic_auth 'whochirp', 'ichirpyouchirp'

	  http.request request do |response|
	    response.read_body do |chunk|
	    	break unless numtweets < 10000
	    	tweet = JSON.parse(chunk)
	    	if tweet['user'] && tweet['user']['lang'] && tweet['user']['lang'] == 'en' && tweet['text'].length <= 144
	    		numtweets += 1
	    		#puts tweet['id']
	    		#puts tweet['text']
	    		Tweet.create(:tid => tweet['id'], :text => tweet['text'])
	    	end
	    end
	    break
	  end
	end
  end
end