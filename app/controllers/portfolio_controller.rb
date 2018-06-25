class PortfolioController < ApplicationController
  def view
  	@bought_assets = BoughtAsset.all
  end
  def add_asset
  	id = params[:asset_quantity]["id"]
  	quantity = params[:asset_quantity]["quantity"]
	@asset = Asset.find_by asset_id:id
	@bought_asset = BoughtAsset.find_by asset_id:id
	if @bought_asset.nil?
		@bought_asset = BoughtAsset.new(asset_id: id, asset_name: @asset.asset_name, asset_value: @asset.asset_value, quantity: quantity)
	else
		@bought_asset.quantity = @bought_asset.quantity.to_f + quantity.to_f
	end
	@bought_asset.save
  	redirect_to action: "view"
  end
end
