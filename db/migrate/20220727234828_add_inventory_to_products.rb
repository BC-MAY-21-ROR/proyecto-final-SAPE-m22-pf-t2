class AddInventoryToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :inventory, null: false, foreign_key: true
  end
end
