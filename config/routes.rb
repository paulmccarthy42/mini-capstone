Rails.application.routes.draw do
  namespace :v1 do
    get "/product" => "products#one_product"
    get "/products" => "products#display_products"
    get "/active_products" => "products#display_active_products"
    get "/restock" => "products#restock"
    get "/buy_product" => "products#buy_product"
  end

  namespace :v2 do
    get "/product/:id" => "products#one_product"
    get "/products" => "products#display_products"
    get "/active_products" => "products#display_active_products"
    get "/restock" => "products#restock"
    get "/buy_product" => "products#buy_product"
  end

  namespace :v3 do
    get "/products" => "products#index"
    post "/products" => "products#create"
    get "/products/:id" => "products#show"
    patch "/products/:id" => "products#update"
  end
end
