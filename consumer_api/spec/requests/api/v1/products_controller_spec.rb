require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  let(:product) { products(:one) }
  let(:valid_params) do
    {
      product: {
        product_id: "123ABC",
        product_name: "Test Product",
        product_category_id: "CAT123",
        country: "BR",
        shop_name: "Test Shop",
        price: 99.99,
        url: "http://example.com/product"
      }
    }
  end

  describe "GET /api/v1/products" do
    context "for SQL database" do
      before do
        allow_any_instance_of(ProductService)
          .to receive(:fetch_all)
          .and_return([product])
      end

      it "returns a successful response" do
        get api_v1_products_path, as: :json

        expect(response).to have_http_status(:success)
        expect(response.body).to include(product.product_name)
      end
    end

    context "for MongoDB database" do
      before do
        allow_any_instance_of(ProductMongoService)
          .to receive(:fetch_all)
          .and_return([product])
      end

      it "returns a successful response" do
        get api_v1_products_path(db: 'mongoid'), as: :json

        expect(response).to have_http_status(:success)
        expect(response.body).to include(product.product_name)
      end
    end
  end
end
