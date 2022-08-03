class AddClientToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :client, :string
  end
end
