class CreateProductSales < ActiveRecord::Migration[7.0]
  def change
    create_table :product_sales do |t|
      t.belongs_to :product
      t.belongs_to :sale
      t.integer :quantity

      t.timestamps
    end
  end
end
