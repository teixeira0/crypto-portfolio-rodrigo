class Asset < ApplicationRecord
	def new(asset_id, asset_name, asset_value)
		@asset_id = asset_id
		@asset_name = asset_name
		@asset_value = asset_value
	end
end
