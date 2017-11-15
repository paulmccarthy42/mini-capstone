require "unirest"

puts "Welcome to the PokeMart"
response =Unirest.get("http://localhost:3000/active_products")

active_products = response.body

while true
  active_products.each do |product|
    puts "#{product["id"]}. #{product["name"]} cost: #{product["price"]}"
  end
  choice = gets.chomp.to_i
  if choice == 0
    break
  end
end