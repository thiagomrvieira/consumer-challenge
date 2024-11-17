require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it "is invalid without a product_id" do
      product = build(:product, product_id: nil)
      product.valid?
      expect(product.errors[:product_id]).to include("can't be blank")
    end

    it "is invalid without a price" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("is not a number")
    end
  end

  describe "normalization" do
    it "removes country codes from shop_name" do
      product = build(:product, shop_name: "BE NL Amazon", country: "BE", price: 100.0)
      product.save
      expect(product.shop_name).to eq("Amazon")
      expect(product.country).to eq("")
    end

    it "removes patterns regardless of case" do
      product = build(:product, shop_name: "be nl AMAZON", country: "nL Fr", price: 100.0)
      product.save
      expect(product.shop_name).to eq("AMAZON")
      expect(product.country).to eq("")
    end

    it "preserves unrelated text in shop_name and country" do
      product = build(:product, shop_name: "My BE NL Shop", country: "United Kingdom", price: 100.0)
      product.save
      expect(product.shop_name).to eq("My Shop")
      expect(product.country).to eq("United Kingdom")
    end
  end
end
