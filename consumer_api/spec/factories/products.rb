FactoryBot.define do
    factory :product do
      product_id { "PROD001" }
      product_name { "iPhone 14 Pro" }
      product_category_id { "SMARTPHONES" }
      country { "BR" }
      shop_name { "Fast Shop" }
      price { 5999.99 }
      url { "https://fastshop.com.br/iphone-14-pro" }
    end
  end
