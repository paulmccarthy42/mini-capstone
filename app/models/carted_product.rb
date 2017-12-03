class CartedProduct < ApplicationRecord
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  belongs_to :product
  belongs_to :user
  belongs_to :order, optional: true
end
