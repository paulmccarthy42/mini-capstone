Rails.application.routes.draw do
  get "/product/:id" => "products#one_product#:id"
  get "/products" => "products#display_products"
  get "/active_products" => "products#display_active_products"
  get "/restock" => "products#restock"
  get "/buy_product" => "products#buy_product"
end
