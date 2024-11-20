class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :brand
      t.string :product_name
      t.string :product_category_id
      t.string :country
      t.string :shop_name
      t.decimal :price
      t.string :url

      t.timestamps
    end

    add_index :products, [:country, :product_id, :shop_name], unique: true, name: 'idx_products_unique_constraint'
  end
end
