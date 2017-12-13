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

  def as_json
    {
      id: id,
      name: name,
      price: price,
      description: description,
      in_stock?: stock > 0,
      stock: stock
    }
  end
end

