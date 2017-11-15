require "unirest"
require "pp"

puts "Welcome to the PokeMart!"

gets.chomp
while true
  response =Unirest.get("http://localhost:3000/products")
  active_products = response.body.sort_by{|x| x["id"]}
  
  system "clear"

  puts "What would you like to buy?"
  active_products.each do |product|
    puts "#{product["id"]}. #{product["name"]} cost: #{product["price"]} (#{(product["stock"] > 0 ? "" : "Not ") + "In Stock"})"
  end
  puts ""
  choice = gets.chomp.to_i
  if choice == 0
    break
  else
    chosen_product = active_products[choice - 1]
    pp chosen_product
    puts "Would you like to buy a #{chosen_product["name"]}, y/n?"
    input = gets.chomp
    if input.downcase == 'y'
      response = Unirest.get("http://localhost:3000/buy_product")
      puts "bought"
    else
      puts "not bought"
    end
    gets.chomp
  end
end