class RemoveStockToProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :stock, :integer
  end
end
