class ProductMongo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :product_id, type: String
  field :product_name, type: String
  field :product_category_id, type: String
  field :country, type: String
  field :shop_name, type: String
  field :price, type: BigDecimal
  field :url, type: String

  index({ country: 1, product_id: 1, shop_name: 1 }, unique: true)
end
