class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.integer :price
      t.text :description
      t.references :business

      t.timestamps
    end
  end
end
