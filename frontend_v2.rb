require "unirest"
require "pp"

puts "Welcome to the PokeMart!"

gets.chomp
while true
  response =Unirest.get("http://localhost:3000/v2/products")
  active_products = response.body.sort_by{|x| x["id"]}
  
  system "clear"

  puts "What would you like to buy?"
  active_products.each do |product|
    puts "#{product["id"]}. #{product["name"]} cost: #{product["price"]} (#{(product["stock"] > 0 ? "" : "Not ") + "In Stock"})"
  end
  puts ""
  choice = gets.chomp
  if choice == "restock"
    puts "restocking"
    response =Unirest.get("http://localhost:3000/v2/restock")
    gets.chomp
  elsif choice.to_i == 0
    break
  else
    chosen_product = active_products[choice.to_i - 1]
    pp chosen_product
    puts "Would you like to buy a #{chosen_product["name"]}, y/n?"
    input = gets.chomp
    if input.downcase == 'y'
      puts "How many would you like to buy?"
      number_of_purchases = gets.chomp.to_i
      number_of_purchases.times do
        if chosen_product["stock"] > 0
          response = Unirest.get("http://localhost:3000/v2/buy_product/?id=#{chosen_product["id"]}")
        else 
          number_of_purchases -= 1
        end
      end
      puts "bought #{number_of_purchases} #{chosen_product["name"] + (number_of_purchases != 1 ? "s" : "")}"
    else
      puts "not bought"
    end
    gets.chomp
  end
end