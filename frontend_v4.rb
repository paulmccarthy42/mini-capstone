require "unirest"

class Frontend
  def initialize
    @jwt = nil
    @base_url = "http://localhost:3000/v3"
  end

  #Basic variables
  def humanized_product(product)
    puts "#{product["id"]}. #{product["name"]}"
    puts "#{product["description"].capitalize}"
    puts "#{product["product_type"].capitalize}" 
    puts "Cost: #{product["price"]}"
    puts "#{product["stock"] > 0 ? "In stock" : "Not in stock"}"
  end

  def humanized_method_name(method)
    name = "#{method.name}"
    name.split("_").join(" ").capitalize
  end

  #Special functions
  def search_for_a_product
    print "What would you like to see in the name? "
    search_choice = gets.chomp
    response = Unirest.get("#{@base_url}/products", parameters: {search: search_choice})
    products = response.body
    products.each {|x| puts humanized_product(x)}
  end

  #Product Methods +
  def display_all_products
    response = Unirest.get("#{@base_url}/products")
    response.body.each {|x| puts humanized_product(x)}
  end

  def search_all_products
    print "Order by? "
    order_choice = gets.chomp
    order_choice = nil if order_choice == ""
    response = Unirest.get("#{@base_url}/products",
      parameters: {order: order_choice})
    if response.code == 200
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
    puts "What is the image of the product?"
    inputs["image"] = gets.chomp
    puts "What is the type of the product?"
    inputs["product_type"] = gets.chomp
    puts "What is the description of the product?"
    inputs["description"] = gets.chomp
    puts "What is the stock of the product?"
    inputs["stock"] = gets.chomp.to_i
    response = Unirest.post("#{@base_url}/products", parameters: inputs)
    puts humanized_product(response.body)
  end

  def read_a_product
    puts "Which ID would you like to see?"
    id = gets.chomp
    response = Unirest.get("#{@base_url}/products/#{id}")
    puts humanized_product(response.body)
  end

  def update_a_product
    puts "which ID would you like to update?"
    id = gets.chomp
    inputs = {}

    puts "What would you like to update?"
    response = Unirest.get("#{@base_url}/products/#{id}")
    response.body.each do |key, value| 
      if !["id", "created_at", "updated_at"].include?(key) 
        puts "#{key.capitalize}: #{value}"
      end
    end
    updated_key = gets.chomp.downcase
    puts "What would you like to update #{updated_key} to?"
    updated_value = gets.chomp
    params = {updated_key => updated_value}

    response = Unirest.patch("#{@base_url}/products/#{id}", 
       parameters: params)
    puts humanized_product(response.body)
  end

  def destroy_a_product
    puts "which ID would you like to destroy?"
    id = gets.chomp
    response = Unirest.delete("#{@base_url}/v3/products/#{id}")
    puts response.code == 200 ? "Success!" : "No luck"
  end

  def restock_all_products
    response = Unirest.get("#{@base_url}/products")
    products = response.body
    products.each do |x|
      response = Unirest.patch("#{@base_url}/products/#{x["id"]}", 
       parameters: {"stock" => 10})
    end
    response = Unirest.get("#{@base_url}/products")
    products = response.body
    products.each {|x| puts humanized_product(x)}
  end

  #order methods
  def order_a_product
    display_all_products
    params = {}
    print "What is the id of the product you want to buy?"
    params["product_id"] = gets.chomp
    puts "How many do you want to buy?"
    params["quantity"] = gets.chomp
    post_response = Unirest.post("http://localhost:3000/orders",
      parameters: params)
    puts post_response.body
  end

  def display_orders
    response = Unirest.get("http://localhost:3000/orders")
    puts response.body
  end

  #user functions
  def create_a_user
    params = {}
    puts "What is your user's name?"
    params["name"] = gets.chomp
    puts "What is your user's email?"
    params["email"] = gets.chomp
    puts "What is your user's access level?"
    params["access_level"] = gets.chomp
    puts "Please enter a password"
    params["password"] = gets.chomp
    puts "Please confirm your password"
    params["password_confirmation"] = gets.chomp
    response = Unirest.post("#{@base_url}/users", parameters: params)
    puts response.body
    authenticate(params)
  end

  def login
    system 'clear'
    params = {}
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    authenticate(params)
  end

  def logout
    Unirest.clear_default_headers()
    puts "Goodbye :)"
    @jwt == nil ? exit : @jwt = nil
  end

  def authenticate(credentials)
    response = Unirest.post("http://localhost:3000/user_token",
      parameters: {auth: credentials})
    @jwt = response.body["jwt"]
    if @jwt == nil
      puts "No luck, try again"
    else
      puts "Success"
      Unirest.default_header("Authorization", "Bearer #{@jwt}")
    end
  end

  #menu choices
  def main_menu_options
    [method(:display_all_products),
    method(:create_a_product),
    method(:read_a_product),
    method(:update_a_product),
    method(:destroy_a_product),
    method(:restock_all_products),
    method(:search_for_a_product),
    method(:order_a_product),
    method(:display_orders),
    method(:logout)
    ]
  end

  def startup_menu_options
    [method(:login),
    method(:create_a_user),
    method(:logout)]
  end

  def menu(options)
    system "clear"
    puts "What would you like to do?"
    options.each do |choice|
      puts "[#{options.index(choice) + 1}] #{humanized_method_name(choice)}"
    end
    option = gets.chomp.to_i
    if option > options.length || option == 0
      puts "Invalid selection, try again"
    else
      options[option - 1].call
    end
    gets.chomp
  end

  #Core engine for the app
  def run
    while @jwt == nil
      "Welcome to the pokemart"
      menu(startup_menu_options)
      while @jwt != nil
        menu(main_menu_options)
      end
    end
  end
end

frontend = Frontend.new
frontend.run

#TODO: Orders suck