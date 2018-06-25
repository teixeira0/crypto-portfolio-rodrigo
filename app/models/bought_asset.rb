class BoughtAsset < ApplicationRecord
	def new(asset_id, asset_name, asset_value, quantity)
		@asset_id = asset_id
		@asset_name = asset_name
		@asset_value = asset_value
		@quantity = quantity
	end
end
