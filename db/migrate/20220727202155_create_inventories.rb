class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :product_description
      t.integer :stock
      t.integer :incomes
      t.integer :outcomes

      t.timestamps
    end
  end
end
