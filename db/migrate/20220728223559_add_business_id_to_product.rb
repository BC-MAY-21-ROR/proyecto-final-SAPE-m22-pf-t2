class AddBusinessIdToProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :business, null: false, foreign_key: true
  end
end
