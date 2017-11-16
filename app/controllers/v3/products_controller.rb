class V3::ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def show
    id = params["id"]
    product = Product.find_by(id: id)
    render json: product
  end
end
