class DropPurcharsesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :purchases
  end
end
