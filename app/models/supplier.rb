class Supplier < ApplicationRecord
  has_many :products

  def as_json
    {
      name: name,
      email: email,
      phone_number: phone_number,
      products: products.as_json
    }
  end
end
