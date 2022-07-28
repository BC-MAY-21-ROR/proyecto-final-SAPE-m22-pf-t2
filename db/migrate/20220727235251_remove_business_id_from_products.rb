class RemoveBusinessIdFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :business_id
  end
end
