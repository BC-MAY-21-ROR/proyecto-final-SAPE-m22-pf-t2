class DropProductResuppliesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :product_resupplies
  end
end
