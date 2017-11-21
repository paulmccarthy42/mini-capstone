require "unirest"
require "pp"

# def display_product(product)
#   puts "#{product["name"]}"
# end

# response = Unirest.get("http://localhost:3000/v3/products")
# products = response.body
# products.each { |x| display_product(x)}

def base_url 
  "http://localhost:3000/v3"
end

def display
  response = Unirest.get("#{base_url}/products")
  products = response.body
  products.each {|x| pp x}
end

def create
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
  pp response.body
end

def read
  puts "Which ID would you like to see?"
  id = gets.chomp
  response = Unirest.get("#{base_url}/products/#{id}")
  pp response.body
end

def update
  puts "Update"
end

def destroy
  puts "which ID would you like to destroy?"
  id = gets.chomp
  response = Unirest.delete("#{base_url}/v3/products/#{id}")
  puts response.code == 200 ? "Success!" : "No luck"
end

def restock
  response = Unirest.get("#{base_url}/products")
  products = response.body
  products.each do |x|
    response = Unirest.patch("#{base_url}/products/#{x["id"]}", 
     parameters: {"stock" => 10})
  end
  response = Unirest.get("#{base_url}/products")
  products = response.body
  pp products.sort_by {|x| x["id"]}
end

def run(menu_options)
  while true
    system "clear"
    puts "Welcome to the pokemart"
    puts "What would you like to do?"
    puts "[1] Display all products"
    puts "[2] Create a product"
    puts "[3] Read a product"
    puts "[4] Update a product"
    puts "[5] Delete a product"
    puts "[6] Restock"
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

routing = [method(:display),
  method(:create),
  method(:read),
  method(:update),
  method(:destroy),
  method(:restock)
]

run(routing)