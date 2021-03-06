class V3::CartedProductsController < ApplicationController
  before_action :authenticate_user

  def create
    carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params["product_id"],
      quantity: params["quantity"],
      status: "carted",
      order_id: nil
      )
    if carted_product.save
      render json: carted_product.as_json
    else
      render json: {errors: carted_product.errors.full_messages}, status: :bad_request
    end
  end

  def index
    shopping_cart = current_user.carted_products #can use user.carted_products relationship instead
    shopping_cart = shopping_cart.where(status: "carted")
    render json: shopping_cart
  end

  def destroy
    id = params["id"]
    carted_product = CartedProduct.find_by(id: id)
    carted_product.status = 'removed'
    if carted_product.save
      render json: carted_product
    else
      render json: {errors: carted_product.errors.full_messages}, status: :bad_request
    end

  end

end
