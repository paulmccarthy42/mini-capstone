class ProductsController < ApplicationController
  def display_products
    render json: Product.all
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
end
