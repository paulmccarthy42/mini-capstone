require "unirest"
require "pp"

def display_product(product)
  puts "#{product["name"]}"
end

response = Unirest.get("http://localhost:3000/v3/products")
products = response.body
products.each { |x| display_product(x)}
