class V2::ProductsController < ApplicationController
  def display_products
    render json: Product.all
  end

  def one_product
    id = params["id"]
    product = Product.find_by(id: id)
    render json: product.as_json
  end

  def display_active_products
    products = []
    product_pool = Product.all
    product_pool.sort_by {|x| x["id"]}.each do |product|
      if product["stock"] > 0
        products << product
      end
    end

    render json: products.as_json
  end

  def buy_product
    id = params["id"]
    product = Product.find_by(id: id)
    product["stock"] -= 1
    product.save
    render json: product.as_json
  end

  def restock
    products = Product.all
    products.each do |product|
      product["stock"] = 10
      product.save
    end
    render json: Product.all.as_json
  end
end
