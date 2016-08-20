class ProductController < ApplicationController
  def index
    products = Product.all
    render json: products, status: 200
  end
end
