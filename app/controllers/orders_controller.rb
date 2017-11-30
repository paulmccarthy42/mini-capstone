class OrdersController < ApplicationController
  before_action :authenticate_user
  
  def index
    orders = current_user.orders
    render json: orders.as_json
  end

  def create
    params["product_id"] = params["product_id"].to_i
    product = Product.find_by(id: params["product_id"])
    subtotal = params["quantity"].to_i * product.price.to_i
    p subtotal
    tax = (subtotal / 10.0).round(2)
    total = (subtotal + tax).round(2)
    order = Order.new(
      user_id: current_user.id, 
      product_id: params["product_id"], 
      quantity: params["quantity"],
      subtotal: subtotal, 
      tax: tax,
      total: total)
    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.full_messages}, status: :bad_request
    end
  end    
end
