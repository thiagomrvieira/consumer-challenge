module Validatable
	extend ActiveSupport::Concern

	included do
		validates :price, numericality: { greater_than: 0 }
		validates :country, :product_id, :shop_name, presence: true
	end
end