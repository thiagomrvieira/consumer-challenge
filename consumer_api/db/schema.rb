ActiveRecord::Schema[7.2].define(version: 2024_11_16_214022) do
  create_table "products", force: :cascade do |t|
    t.string "product_id"
    t.string "brand"
    t.string "product_name"
    t.string "product_category_id"
    t.string "country"
    t.string "shop_name"
    t.decimal "price", precision: 18
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country", "product_id", "shop_name"], name: "idx_products_unique_constraint", unique: true
  end
end
