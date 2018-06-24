require 'net/http'
require 'openssl'
require 'date'
require 'json'

def request_uri(uri = "", parameters = {})
  	uri = URI.join(uri)
	uri.query = URI.encode_www_form(parameters)
	request = Net::HTTP::Get.new(uri)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	# uncomment only in development enviroment if ruby don't have trusted CA directory
	#http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	response = http.request(request)
	JSON.parse(response.body, symbolize_names: true)
end

class CryptoMarketController < ApplicationController
  def buy
  	coins = request_uri("https://www.cryptocompare.com/api/data/coinlist/")[:Data]
  	best_coins = {}
	for coin in coins.values 
		if coin[:SortOrder].to_i <= 10
			best_coins[coin[:Symbol]] = coin[:CoinName]  
		end
	end
	rates = request_uri("https://min-api.cryptocompare.com/data/pricemulti", {'fsyms': best_coins.keys.join(','), 'tsyms': 'USD'})
	for id, value in rates
		puts "Asset: #{best_coins[id.to_s]} is worth U$ #{value[:USD]}"
	end
  end
end