class Image < ApplicationRecord
  belongs_to :product

  def as_json
    {
      id: id,
      product_id: product_id,
      product: product.name,
      url: url
    }
  end
end
