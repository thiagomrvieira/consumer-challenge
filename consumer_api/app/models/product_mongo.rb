class ProductMongo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Normalizable
  include Validatable

  field :product_id, type: String
  field :brand, type: String
  field :product_name, type: String
  field :product_category_id, type: String
  field :country, type: String
  field :shop_name, type: String
  field :price, type: BigDecimal
  field :url, type: String

  index({ country: 1, product_id: 1, shop_name: 1 }, unique: true)

  validates :price, numericality: { greater_than: 0 }
  validates :country, :product_id, :shop_name, presence: true
end
