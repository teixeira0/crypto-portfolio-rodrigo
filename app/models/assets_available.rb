class AssetsAvailable < ApplicationRecord
	def new(quantity)
		@quantity = quantity
	end
end
