class AddProductPriceToProductSales < ActiveRecord::Migration[7.0]
  def change
    add_column :product_sales, :product_price, :decimal, default: 0.0
  end
end
