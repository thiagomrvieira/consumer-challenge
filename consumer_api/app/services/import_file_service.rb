class ImportFileService
    def initialize(file_path)
      @file_path = file_path
    end

    def call
      json_data = JSON.parse(File.read(@file_path))

      json_data.each do |record|
        next unless record['availability'] == true && record['price'].to_f > 0

        normalized_data = normalize_data(record)

        ProductMongo.find_or_initialize_by(product_id: normalized_data[:product_id])
                    .update(normalized_data)

        Product.find_or_initialize_by(product_id: normalized_data[:product_id])
               .update(normalized_data)
      end
    end

    private

    def normalize_data(record)
      {
        country: record['country'],
        brand: record['brand'],
        product_id: record['sku'],
        product_name: record['model'],
        shop_name: record['ismarketplace'] ? record['marketplaceseller'] : record['site'],
        product_category_id: record['categoryId'],
        price: record['price'],
        url: record['url']
      }
    end
  end
