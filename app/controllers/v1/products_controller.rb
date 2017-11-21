class V1::ProductsController < ApplicationController
  def display_products
    render json: Product.all.as_json
  end

  def one_product
    product = Product.first
    render json: product.as_json
  end

  def display_active_products
    products = []
    Product.all.each do |product|
      if product["stock"] > 0
        products << product
      end
    end

    render json: products.as_json
  end

  def buy_product
    product = Product.first
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
  end
end
