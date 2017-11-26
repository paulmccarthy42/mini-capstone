class MoveImagesToOwnTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :image, :text
  end
end
