require "unirest"
require "pp"

# def display_product(product)
#   puts "#{product["name"]}"
# end

# response = Unirest.get("http://localhost:3000/v3/products")
# products = response.body
# products.each { |x| display_product(x)}

def display
  puts "Display"
end

def create
  puts "Create"
end

def read
  puts "Read"
end

def update
  puts "Update"
end

def destroy
  puts "Destroy"
end

def restock
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

routing = [method(:display),
  method(:create),
  method(:read),
  method(:update),
  method(:destroy),
  method(:restock)
]

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

run(routing)