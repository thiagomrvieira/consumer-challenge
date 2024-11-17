class Product < ApplicationRecord
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
