class ImportBatchJob < ApplicationJob
  queue_as :file_import

  def perform(batch)
    batch.each do |record|
      next unless record['availability'] && record['price'].to_f > 0

      normalized_data = normalize_data(record)

      save_to_sql(normalized_data)
      save_to_mongo(normalized_data)
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
      price: record['price'].to_f,
      url: record['url']
    }
  end

  def save_to_sql(data)
    Product.upsert(data, unique_by: [:country, :product_id, :shop_name])
  end

  def save_to_mongo(data)
    ProductMongo.find_or_create_by(
      country: data[:country],
      product_id: data[:product_id],
      shop_name: data[:shop_name]
    ).update!(data)
  end
end
