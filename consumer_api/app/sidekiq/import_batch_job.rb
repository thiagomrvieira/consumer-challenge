class ImportBatchJob < ApplicationJob
  queue_as :file_import

  def perform(batch)
    batch.each do |record|
      next unless record['availability'] && record['price'].to_f > 0
      normalized_data = DataNormalizer.call(record)

      process_mongo(normalized_data)
      process_sql(normalized_data)
    end
  end

  private

  def process_mongo(data)
    ProductMongo.find_or_create_by(
      country: data[:country],
      product_id: data[:product_id],
      shop_name: data[:shop_name]
    ).update!(data)
  end

  def process_sql(data)
    current_time = Time.now.utc

    sql = <<~SQL
      MERGE INTO products AS target
      USING (SELECT ? AS country, ? AS product_id, ? AS shop_name, ? AS brand,
                    ? AS product_name, ? AS product_category_id, ? AS price,
                    ? AS url, ? AS updated_at, ? AS created_at) AS source
      ON (target.country = source.country AND
          target.product_id = source.product_id AND
          target.shop_name = source.shop_name)
      WHEN MATCHED THEN
        UPDATE SET brand = source.brand,
                   product_name = source.product_name,
                   product_category_id = source.product_category_id,
                   price = source.price,
                   url = source.url,
                   updated_at = source.updated_at
      WHEN NOT MATCHED THEN
        INSERT (country, product_id, shop_name, brand, product_name,
                product_category_id, price, url, created_at, updated_at)
        VALUES (source.country, source.product_id, source.shop_name, source.brand,
                source.product_name, source.product_category_id, source.price,
                source.url, source.created_at, source.updated_at);
    SQL

    ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.send(:sanitize_sql_array, [
        sql,
        data[:country], data[:product_id], data[:shop_name], data[:brand],
        data[:product_name], data[:product_category_id], data[:price], data[:url],
        current_time, current_time
      ])
    )
  end
end
