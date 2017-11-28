
product = Product.new(
  name: "Pokeball", 
  price: "200", 
  product_type: "pokeball",
  description: "catches low level pokemon",
  stock: 10,
  supplier_id: 1)
product.save

image = Image.new(url: 'http://www.thinkgeek.com/images/products/additional/large/jgpo_poke_ball_serving_bowl_set_closed.jpg',
  product_id: 1)
image.save

product = Product.new(
  name: "Great Ball", 
  price: "500", 
  product_type: "pokeball",
  description: "catches mid level pokemon",
  stock: 10,
  supplier_id: 1)
product.save

image = Image.new(
  url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSl0cUOqEo7ALXSmjvwzW3fJi8vvHeomsHW1t5k80Vq32B-gb_A", 
  product_id: 2)
image.save

product = Product.new(
  name: "Ultra Ball", 
  price: "1000", 
  product_type: "pokeball",
  description: "catches high level pokemon",
  stock: 10,
  supplier_id: 1)
product.save

image = Image.new(
  url: "https://vignette2.wikia.nocookie.net/pokemon/images/f/f1/UltraBallArt.png/revision/latest?cb=20101106022319",
  product_id: 3)
image.save

supplier = Supplier.new(
  name: "Silph Co.",
  email: "silph@email.com",
  phone_number: "1111111111")
supplier.save

supplier = Supplier.new(
  name: "Devon",
  email: "devon@email.com",
  phone_number: "1234567890")
supplier.save