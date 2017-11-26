class Supplier < ApplicationRecord
  def products
    Product.where(supplier_id: self.id)
  end

  def as_json
    {
      name: name,
      email: email,
      phone_number: phone_number,
      products: products.as_json
    }
  end
end
