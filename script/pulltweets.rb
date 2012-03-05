#!/usr/bin/env ruby

require 'net/http'
require 'json'

uri = URI('https://stream.twitter.com/1/statuses/sample.json')

Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  request = Net::HTTP::Get.new uri.request_uri
  request.basic_auth 'whochirp', 'ichirpyouchirp'

  http.request request do |response|
    response.read_body do |chunk|
      puts chunk
    end
  end
end


# Net::HTTP.get_response(uri.host, uri.path, uri.port) do |response|
#  response.read_body do |segment|
#    puts segment
#  end
# end