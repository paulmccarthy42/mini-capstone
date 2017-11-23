class V3::ProductsController < ApplicationController
  def index
    product = Product.all.order(:id)
    if params[:search]
      product = product.where("name ilike ?", "%#{params[:search]}%")
    end
    render json: product.as_json
  end

  def create
    product = Product.new(name: params["name"], 
      price: params["price"], 
      image: params["image"],
      product_type: params["product_type"],
      description: params["description"],
      stock: params["stock"])
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :bad_request
    end
  end

  def show
    id = params["id"]
    product = Product.find_by(id: id)
    render json: product.as_json
  end

  def update
    id = params["id"]
    product = Product.find_by(id: id)
    product.name = params["name"] || product.name
    product.price = params["price"] || product.price
    product.image = params["image"] || product.image
    product.product_type = params["product_type"] || product.product_type
    product.description = params["description"] || product.description
    product.stock = params["stock"] || product.stock
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    id = params["id"]
    product = Product.find_by(id: id)
    product.destroy
    render json: "successfully destroyed"
  end
end
