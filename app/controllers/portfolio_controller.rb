# Controls the actions related to the asset portfolio.
class PortfolioController < ApplicationController
  def view	# View the currently bought assets.
  	@bought_assets = BoughtAsset.all
  end
  def reset  # Clear the portfolio.
  	BoughtAsset.delete_all
  	redirect_to action: "view"
  end
  def add_asset # Adds a new asset to the portfolio, after it is bought.  
  	id = params[:asset_quantity]["id"]
  	quantity = params[:asset_quantity]["quantity"]
  	if quantity.to_i > 0 
		@asset = Asset.find_by asset_id:id
		@bought_asset = BoughtAsset.find_by asset_id:id
		if @bought_asset.nil?
			@bought_asset = BoughtAsset.new(asset_id: id, asset_name: @asset.asset_name, asset_value: @asset.asset_value, quantity: quantity)
		else
			@bought_asset.quantity = @bought_asset.quantity.to_f + quantity.to_f
		end
		@bought_asset.save
	end
  	redirect_to action: "view"
  end
end
