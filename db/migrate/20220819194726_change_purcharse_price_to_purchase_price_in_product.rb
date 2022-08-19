class ChangePurcharsePriceToPurchasePriceInProduct < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :purcharse_price, :purchase_price
  end
end
