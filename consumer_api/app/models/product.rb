class Product < ApplicationRecord
	include Normalizable
	include Validatable

  validates :price, numericality: { greater_than: 0 }
  validates :country, :product_id, :shop_name, presence: true
end
