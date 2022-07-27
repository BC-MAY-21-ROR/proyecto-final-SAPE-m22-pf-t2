class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :product
      t.belongs_to :spent
      t.integer :quantity

      t.timestamps
    end
  end
end
