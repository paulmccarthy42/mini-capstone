class Order < ApplicationRecord
  validates :subtotal, :tax, :total, numericality: {greater_than_or_equal_to: 0}

  belongs_to :user
  has_many :carted_products
end
