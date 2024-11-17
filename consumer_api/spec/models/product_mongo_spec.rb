require 'rails_helper'

RSpec.describe ProductMongo, type: :model do
  describe "normalization" do
    it "removes country codes from shop_name" do
      product_mongo = build(:product, shop_name: "be nl AMAZON", country: "nL Fr", price: 100.0)
      product_mongo.save
      expect(product_mongo.shop_name).to eq("AMAZON")
      expect(product_mongo.country).to eq("")
    end

    it "removes patterns regardless of case" do
      product_mongo = build(:product, shop_name: "FR PT MyShop", country: "pt nl")
      product_mongo.save
      expect(product_mongo.shop_name).to eq("MyShop")
      expect(product_mongo.country).to eq("")
    end

    it "preserves unrelated text in shop_name and country" do
      product_mongo = build(:product, shop_name: "NL My Store", country: "USA")
      product_mongo.save
      expect(product_mongo.shop_name).to eq("My Store")
      expect(product_mongo.country).to eq("USA")
    end

    it "removes extra spaces between words" do
      product_mongo = build(:product, shop_name: "My BE NL Store", country: "USA")
      product_mongo.save
      expect(product_mongo.shop_name).to eq("My Store")
      expect(product_mongo.country).to eq("USA")
    end
  end
end
