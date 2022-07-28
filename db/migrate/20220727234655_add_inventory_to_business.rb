class AddInventoryToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_reference :inventories, :business, null: false, foreign_key: true
  end
end
