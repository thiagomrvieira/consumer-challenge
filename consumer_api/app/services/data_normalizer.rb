class DataNormalizer
    def self.call(record)
      shop_name = record['ismarketplace'] ? record['marketplaceseller'] : record['site']

      {
        country: normalize_string(record['country']),
        brand: record['brand'],
        product_id: record['sku'],
        product_name: record['model'],
        shop_name: normalize_string(shop_name),
        product_category_id: record['categoryId'],
        price: record['price'].to_f,
        url: record['url']
      }
    end

    private_class_method def self.normalize_string(string)
      return string unless string
      string.gsub(/\s+\b(be|nl|fr|us|de|uk|br|es|pt)\b(?=\s|$)/i, ' ')
            .strip.gsub(/\s+/, ' ').strip
    end
  end
