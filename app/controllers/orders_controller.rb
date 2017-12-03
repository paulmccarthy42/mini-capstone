class OrdersController < ApplicationController
  before_action :authenticate_user
  
  def index
    orders = current_user.orders
    render json: orders.as_json
  end

  def create
    carted_products = CartedProduct.where(user_id: current_user.id).where(status: "carted")
    subtotal = 0
    carted_products.each do |cart_item|
      subtotal += cart_item.quantity * cart_item.product.price
    end
    tax = (subtotal / 10.0).round(2)
    total = (subtotal + tax).round(2)   
    order = Order.new(
      user_id: current_user.id, 
      subtotal: subtotal, 
      tax: tax,
      total: total)
    if order.save
      carted_products.each do |cart_item|
        cart_item.status = "purchased"
        cart_item.order_id = order.id
        cart_item.save
      end
      render json: order.as_json 
    else
      render json: {errors: order.errors.full_messages}, status: :bad_request
    end
  end    
end


      
