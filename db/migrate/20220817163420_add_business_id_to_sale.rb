class AddBusinessIdToSale < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :business, null: false, foreign_key: true
  end
end
