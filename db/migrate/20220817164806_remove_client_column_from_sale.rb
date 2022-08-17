class RemoveClientColumnFromSale < ActiveRecord::Migration[7.0]
  def change
    remove_column :sales, :client
  end
end
