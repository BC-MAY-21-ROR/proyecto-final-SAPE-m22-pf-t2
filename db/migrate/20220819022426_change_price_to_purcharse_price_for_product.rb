class ChangePriceToPurcharsePriceForProduct < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :price, :purcharse_price
    change_column :products, :purcharse_price, :decimal
  end
end
