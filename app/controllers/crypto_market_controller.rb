require 'net/http'
require 'openssl'
require 'date'
require 'json'
require 'assets_controller'
require 'asset'

# Helper method to obtain http requests, given a URI.
def request_uri(uri = "", parameters = {})
  	uri = URI.join(uri)
	uri.query = URI.encode_www_form(parameters)
	request = Net::HTTP::Get.new(uri)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	response = http.request(request)
	JSON.parse(response.body, symbolize_names: true)
end

# Class responsible for fetching and showing all available assets and their values.
class CryptoMarketController < ApplicationController
  def buy 	# Shows the avaiable assets that can be bought.
  	find_values
	@assets = Asset.all
	@last_updated = LastUpdated.first
	@assets_available = AssetsAvailable.first.quantity
  end
  def update_quantity 	# Updates the number of assets shown in the list.
  	quantity = params[:asset_quantity]["quantity"]
  	if (AssetsAvailable.first.nil?)
		@assets_available = AssetsAvailable.new(quantity: quantity)
	else
		@assets_available = AssetsAvailable.first
		@assets_available.quantity = quantity
	end
	@assets_available.save
	redirect_to action: "refresh"
  end
  def refresh 	# Clears the assets stored in the model, and refills it with updated values. Also uptates the value of previously bought assets.
  	Asset.delete_all
  	find_values
  	assets = Asset.all
  	for asset in assets
  		bought_asset = BoughtAsset.find_by asset_id:asset.asset_id
  		if not bought_asset.nil?
  			bought_asset.asset_value = asset.asset_value
  			bought_asset.save
  		end
  	end
  	redirect_to action: "buy"
  end
  def find_values	# Checks if the assets model is empty. If it is, fills it with the assets from the API.
  	if Asset.first.nil? 
  		if (AssetsAvailable.first.nil?)
  			@assets_available = AssetsAvailable.new(quantity: 10)
  			@assets_available.save
  		end
  		@assets_available = AssetsAvailable.first.quantity
	  	coins = request_uri("https://min-api.cryptocompare.com/data/top/totalvol", {'limit': @assets_available, 'tsym': 'USD'})[:Data]
	  	best_coins = {}
		for coin in coins
			best_coins[coin[:CoinInfo][:Name]] = coin[:CoinInfo][:FullName] 
		end
	  	puts best_coins
		rates = request_uri("https://min-api.cryptocompare.com/data/pricemulti", {'fsyms': best_coins.keys.join(','), 'tsyms': 'USD'})
		for id, value in rates
			asset = Asset.new(asset_id: id, asset_name: best_coins[id.to_s], asset_value: value[:USD])
			asset.save
		end
		if (LastUpdated.first.nil?)
			@last_updated = LastUpdated.new(date: DateTime.now.strftime("%b %d, %Y, %H:%I:%M"))
		else
			@last_updated = LastUpdated.first
			@last_updated.date = DateTime.now.strftime("%d %b %Y, %H:%M:%S")
		end
		@last_updated.save
	end
  end
  def confirm 	# Confirms the purchase of a specific asset.
  	@assets = Asset.all
  	@buy_id = params[:data]
  end
end
