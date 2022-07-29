class RemoveInventoryIdFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :inventory_id
  end
end
