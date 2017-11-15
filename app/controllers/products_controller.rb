class ProductsController < ApplicationController
  def display_products
    render json: Product.all
  end

  def one_product
    product = Product.find_by(id: :id)
    render json: product
  end

  def display_active_products
    products = []
    Product.all.each do |product|
      if product["stock"] > 0
        products << product
      end
    end

    render json: products
  end

  def buy_product
    product = Product.first
    product["stock"] -= 1
    product.save
    render json: product
  end

  def restock
    products = Product.all
    products.each do |product|
      product["stock"] = 10
      product.save
    end
  end
end
