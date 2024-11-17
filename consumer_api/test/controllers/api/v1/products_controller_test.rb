require "test_helper"
require 'mocha/minitest'
include Rails.application.routes.url_helpers

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @valid_params = {
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

  test "should get index for SQL" do
    ProductService.any_instance.stubs(:fetch_all).returns([@product])

    get api_v1_products_url, as: :json
    assert_response :success
    assert_includes @response.body, @product.product_name
  end

  test "should get index for MongoDB" do
    ProductMongoService.any_instance.stubs(:fetch_all).returns([@product])

    get api_v1_products_url(db: 'mongoid'), as: :json
    assert_response :success
    assert_includes @response.body, @product.product_name
  end
end
