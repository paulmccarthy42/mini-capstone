class V3::ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def create
    product = Product.new(name: params["name"], 
      price: params["price"], 
      image: params["image"],
      product_type: params["product_type"],
      description: params["description"],
      stock: params["stock"])
    product.save
    render json: product
  end

  def show
    id = params["id"]
    product = Product.find_by(id: id)
    render json: product
  end

  def update
    id = params["id"]
    product = Product.find_by(id: id)
    product.name = params["name"]
    product.price = params["price"]
    product.image = params["image"]
    product.product_type = params["product_type"]
    product.description = params["description"]
    product.stock = params["stock"]
    product.save
    render json: product
  end
end
