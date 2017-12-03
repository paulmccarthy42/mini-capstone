class Product < ApplicationRecord
  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :description, length: {in: 5..500}
  validates :price, numericality: {only_integer: true}
  validates :price, numericality: {greater_than_or_equal_to: 0}

  belongs_to :supplier
  has_many :images
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :carted_products

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
      description: description,
      stock: stock,
      is_discounted?: is_discounted?,
      images: images.as_json,
      categories: categories.as_json,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end