class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.integer :incomes
      t.integer :outcomes
      t.integer :stock
      t.timestamps
    end
  end
end
