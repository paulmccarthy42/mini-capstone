require "unirest"
require "pp"

def restock()
  response = Unirest.get("http://localhost:3000/v3/products")
  products = response.body
  products.each do |x|
    response = Unirest.patch("http://localhost:3000/v3/products/#{x["id"]}", 
     parameters: {"stock" => 10})
  end
  response = Unirest.get("http://localhost:3000/v3/products")
  products = response.body
  pp products.sort_by {|x| x["id"]}
end

system "clear"
puts "Welcome to the pokemart"
puts "What would you like to do?"
puts "[1] Display all products"
puts "[2] Add a product"
puts "[3] Display a product"
puts "[4] Update a product"
puts "[5] Delete a product"
puts "[6] Restock"
puts "[7] Quit"
option = gets.chomp.to_i

if option == 1
  response = Unirest.get("http://localhost:3000/v3/products")
  products = response.body
  pp products
elsif option == 2
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
  response = Unirest.post("http://localhost:3000/v3/products", parameters: inputs)
  pp response.body
elsif option == 3
  puts "Which ID would you like to see?"
  id = gets.chomp
  response = Unirest.get("http://localhost:3000/v3/products/#{id}")
  pp response.body
elsif option == 4
  puts "which ID would you like to update?"
  id = gets.chomp
  inputs = {}

  puts "What would you like to update?"
  response = Unirest.get("http://localhost:3000/v3/products/#{id}")
  response.body.each do |key, value| 
    if !["id", "created_at", "updated_at"].include?(key) 
      puts "#{key.capitalize}: #{value}"
    end
  end
  updated_key = gets.chomp
  puts "What would you like to update #{updated_key} to?"
  updated_value = gets.chomp
  params = {updated_key => updated_value}

  response = Unirest.patch("http://localhost:3000/v3/products/#{id}", 
     parameters: params)
  pp response.body
elsif option == 5
  puts "which ID would you like to destroy?"
  id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v3/products/#{id}")
  puts response.body
elsif option == 6
  restock()
end