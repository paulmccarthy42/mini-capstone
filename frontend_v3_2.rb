require "unirest"

#Basic variables
def base_url 
  "http://localhost:3000/v3"
end

def menu_options
  [method(:display_all_products),
  method(:create_a_product),
  method(:read_a_product),
  method(:update_a_product),
  method(:destroy_a_product),
  method(:restock_all_products),
  method(:search_for_a_product)
  ]
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
  puts "What is the image of the product?"
  inputs["image"] = gets.chomp
  puts "What is the type of the product?"
  inputs["product_type"] = gets.chomp
  puts "What is the description of the product?"
  inputs["description"] = gets.chomp
  puts "What is the stock of the product?"
  inputs["stock"] = gets.chomp.to_i
  response = Unirest.post("#{base_url}/products", parameters: inputs)
  puts humanized_product(response.body)
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

#Core engine for the app
def run
  while true
    system "clear"
    puts "Welcome to the pokemart"
    puts "What would you like to do?"
    menu_options.each do |choice|
      puts "[#{menu_options.index(choice) + 1}] #{humanized_method_name(choice)}"
    end
    puts "Input anything else to quit"
    option = gets.chomp.to_i
    if option > menu_options.length || option == 0
      break
    else
      menu_options[option - 1].call
    end
    gets.chomp
  end
end

#tester
run