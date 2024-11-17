class Api::V1::ProductsController < ApplicationController
  def index
    products = product_service.fetch_all
    render json: products
  end

  private

  def product_service
    params[:db] == 'mongoid' ? ProductMongoService.new : ProductService.new
  end
end