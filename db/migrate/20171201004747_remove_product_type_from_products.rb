class RemoveProductTypeFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :product_type, :string
  end
end
