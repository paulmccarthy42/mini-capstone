Rails.application.routes.draw do
  get "/products" => "products#display_products"
  get "/active_products" => "products#display_active_products"
end
