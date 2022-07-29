class RemoveIncomesAndOutcomesFromInventory < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :incomes
    remove_column :inventories, :outcomes
  end
end
