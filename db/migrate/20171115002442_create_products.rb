class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.string :image
      t.string :product_type
      t.string :description

      t.timestamps
    end
  end
end
