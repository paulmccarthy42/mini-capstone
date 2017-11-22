class Product < ApplicationRecord
  # Name - presence - uniqueness
  # Price - presence - numericality
  # Description - length of a minimum of 200 and a maximum of 500 characters
  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :description, length: {in: 5..500}

  def is_discounted?
    price.to_i < 300 ? true : false
  end

  def tax
    price.to_i * 0.09
  end

  def total
    price.to_f + tax
  end

  def as_json
    {
      id: id,
      name: name,
      price: price,
      tax: tax,
      total: total,
      image: image,
      product_type: product_type,
      description: description,
      stock: stock,
      is_discounted?: is_discounted?,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end