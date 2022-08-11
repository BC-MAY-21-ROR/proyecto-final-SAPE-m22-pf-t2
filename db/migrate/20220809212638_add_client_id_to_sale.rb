class AddClientIdToSale < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :client, null: false, foreign_key: true
  end
end
