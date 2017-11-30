require "unirest"
require "pp"

#Basic variables
def base_url 
  "http://localhost:3000/v3"
end

def humanized_product(product)
  """#{product["id"]}. #{product["name"]}
#{product["description"].capitalize}
#{product["product_type"].capitalize} 
Cost: #{product["price"]}
#{product["stock"] > 0 ? "In stock" : "Not in stock"}

"""
end

def humanized_method_name(method)
  name = "#{method.name}"
  name.split("_").join(" ").capitalize
end


#Special functions
def search_for_a_product
  print "What would you like to see in the name? "
  search_choice = gets.chomp
  response = Unirest.get("#{base_url}/products", parameters: {search: search_choice})
  products = response.body
  products.each {|x| puts humanized_product(x)}
end

#CRUD Methods +
def display_all_products
  print "Order by? "
  order_choice = gets.chomp
  order_choice = nil if order_choice == ""
  response = Unirest.get("#{base_url}/products",
    parameters: {order: order_choice})
  if response.body == 200
    products = response.body
    products.each {|x| puts humanized_product(x)}
  else
    puts "Sorry, I don't think that's a valid column name"
  end
end

def create_a_product
  inputs = {}
  puts "What is the name of the product?"
  inputs["name"] = gets.chomp
  puts "What is the price of the product?"
  inputs["price"] = gets.chomp.to_i
  puts "What is the type of the product?"
  inputs["product_type"] = gets.chomp
  puts "What is the description of the product?"
  inputs["description"] = gets.chomp
  puts "What is the stock of the product?"
  inputs["stock"] = gets.chomp.to_i
  response = Unirest.post("#{base_url}/products", parameters: inputs)
  if response.code == 401
    puts "No luck, non admin user"
  else
    p humanized_product(response.body)
  end
end

def read_a_product
  puts "Which ID would you like to see?"
  id = gets.chomp
  response = Unirest.get("#{base_url}/products/#{id}")
  puts humanized_product(response.body)
end

def update_a_product
  puts "which ID would you like to update?"
  id = gets.chomp
  inputs = {}

  puts "What would you like to update?"
  response = Unirest.get("#{base_url}/products/#{id}")
  response.body.each do |key, value| 
    if !["id", "created_at", "updated_at"].include?(key) 
      puts "#{key.capitalize}: #{value}"
    end
  end
  updated_key = gets.chomp.downcase
  puts "What would you like to update #{updated_key} to?"
  updated_value = gets.chomp
  params = {updated_key => updated_value}

  response = Unirest.patch("#{base_url}/products/#{id}", 
     parameters: params)
  puts humanized_product(response.body)
end

def destroy_a_product
  puts "which ID would you like to destroy?"
  id = gets.chomp
  response = Unirest.delete("#{base_url}/v3/products/#{id}")
  puts response.code == 200 ? "Success!" : "No luck"
end

def restock_all_products
  response = Unirest.get("#{base_url}/products")
  products = response.body
  products.each do |x|
    response = Unirest.patch("#{base_url}/products/#{x["id"]}", 
     parameters: {"stock" => 10})
  end
  response = Unirest.get("#{base_url}/products")
  products = response.body
  products.each {|x| puts humanized_product(x)}
end

#user functions
def create_a_user
  params = {}
  puts "What is your user's name?"
  params["name"] = gets.chomp
  puts "What is your user's email?"
  params["email"] = gets.chomp
  puts "Please enter a password"
  params["password"] = gets.chomp
  puts "Please confirm your password"
  params["password_confirmation"] = gets.chomp
  response = Unirest.post("#{base_url}/users", parameters: params)
  puts response.body
end

def login
  jwt = nil
  while jwt == nil
    system 'clear'
    params = {}
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token",
      parameters: {auth: params})
    jwt = response.body["jwt"]
    p jwt
    if jwt == nil
      puts "No luck, try again"
    else
      puts "Success"
      Unirest.default_header("Authorization", "Bearer #{jwt}")
    end
    gets.chomp
  end
end

def logout
  Unirest.clear_default_headers()
  puts "Goodbye :)"
  exit
end

def order_a_product
  puts "You're buying pokeballs. Deal with it"
  params = {}
  params["product_id"] = 1
  puts "How many do you want to buy?"
  params["quantity"] = gets.chomp.to_i
  post_response = Unirest.post("http://localhost:3000/orders",
    parameters: params)
  response = Unirest.get("http://localhost:3000/orders")
  pp response.body
  pp response.headers
end

def main_menu_options
  [method(:display_all_products),
  method(:create_a_product),
  method(:read_a_product),
  method(:update_a_product),
  method(:destroy_a_product),
  method(:restock_all_products),
  method(:search_for_a_product),
  method(:order_a_product),
  method(:logout)
  ]
end

def startup_menu_options
  [method(:display_all_products),
  method(:login),
  method(:create_a_user),
  method(:logout)]
end

def startup
  puts "Welcome to the pokemart"
  puts "[1] sign up"
  puts "[2] log in"
  choice = gets.chomp.to_i
  if choice == 1
    create_a_user
    true
  elsif choice == 2
    login
    p current_user
    true
  else
    false
  end
end

#Core engine for the app
def run
  while true
    system "clear"
    puts "What would you like to do?"
    main_menu_options.each do |choice|
      puts "[#{main_menu_options.index(choice) + 1}] #{humanized_method_name(choice)}"
    end
    option = gets.chomp.to_i
    if option > main_menu_options.length || option == 0
      puts "Invalid selection, try again"
    else
      main_menu_options[option - 1].call
    end
    gets.chomp
  end
end

#tester
if startup
  run
end