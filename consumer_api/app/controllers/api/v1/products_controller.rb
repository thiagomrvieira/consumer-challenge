class Api::V1::ProductsController < ApplicationController
  def index
    products = product_service.fetch_all.page(params[:page] || 1).per(params[:per_page] || 10)

    render json: {
      data: products,
      meta: {
        current_page: products.current_page,
        total_pages: products.total_pages,
        total_count: products.total_count
      }
    }
  end

  private

  def product_service
    params[:db] == 'mongoid' ? ProductMongoService.new : ProductService.new
  end
end