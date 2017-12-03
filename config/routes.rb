Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
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
    delete "/products/:id" => "products#destroy"
    post "/users" => "users#create"
    get "/categories" => "categories#index"
    get "/carted_products" => "carted_products#index"
    post "/carted_products" => "carted_products#create"
    delete "/carted_products/:id" => "carted_products#destroy"
  end

  post "/orders" => "orders#create"
  get "/orders" => "orders#index"
  get "/suppliers" => "suppliers#index"
  post "/suppliers" => "suppliers#create"
  get "/suppliers/:id" => "suppliers#show"
  patch "/suppliers/:id" => "suppliers#update"
  delete "/suppliers/:id" => "suppliers#destroy"

end
