class SuppliersController < ApplicationController
  def index
    supplier = Supplier.all.order(params[:order] || :id)
    if params[:search]
      supplier = supplier.where("name ilike ?", "%#{params[:search]}%")
    end
    render json: supplier.as_json
  end

  def create
    supplier = Supplier.new(name: params["name"], 
      email: params["email"], 
      phone_number: params["phone_number"])
    if supplier.save
      render json: supplier.as_json
    else
      render json: {errors: supplier.errors.full_messages}, status: :bad_request
    end
  end

  def show
    id = params["id"]
    supplier = Supplier.find_by(id: id)
    render json: supplier.as_json
  end

  def update
    id = params["id"]
    supplier = Supplier.find_by(id: id)
    supplier.name = params["name"] || supplier.name
    supplier.price = params["email"] || supplier.email
    supplier.image = params["phone_number"] || supplier.phone_number
    if supplier.save
      render json: supplier.as_json
    else
      render json: {errors: supplier.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    id = params["id"]
    supplier = Supplier.find_by(id: id)
    supplier.destroy
    render json: "successfully destroyed"
  end
end
