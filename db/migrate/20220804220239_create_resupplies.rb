class CreateResupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :resupplies do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.text :comment

      t.timestamps
    end
  end
end
