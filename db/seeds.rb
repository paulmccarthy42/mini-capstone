# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
product = Product.new(
  name: "Pokeball", 
  price: "200", 
  image: "http://www.thinkgeek.com/images/products/additional/large/jgpo_poke_ball_serving_bowl_set_closed.jpg",
  product_type: "pokeball",
  description: "catches low level pokemon",
  stock: 10)
product.save

product = Product.new(
  name: "Great Ball", 
  price: "500", 
  image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl0cUOqEo7ALXSmjvwzW3fJi8vvHeomsHW1t5k80Vq32B-gb_A",
  product_type: "pokeball",
  description: "catches mid level pokemon",
  stock: 10)
product.save

product = Product.new(
  name: "Ultra Ball", 
  price: "1000", 
  image: "data:image/jpeg;base64,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",
  product_type: "pokeball",
  description: "catches high level pokemon",
  stock: 10)
product.save