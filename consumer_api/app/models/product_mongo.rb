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

  validates :price, numericality: { greater_than: 0 }
  validates :country, :product_id, :shop_name, presence: true

  before_save :normalize_fields

  private

  def normalize_fields
    self.shop_name = normalize_string(shop_name)
    self.country = normalize_string(country)
  end

	def normalize_string(string)
    return string unless string
    string = string.gsub(/\b(be|nl|fr|us|de|uk|br|es|pt)\b/i, '').strip
    string = string.gsub(/\s+/, ' ')
    string.strip
  end
end
