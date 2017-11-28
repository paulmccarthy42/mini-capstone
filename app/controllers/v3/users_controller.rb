class V3::UsersController < ApplicationController
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      access_level: params[:access_level],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end
end
