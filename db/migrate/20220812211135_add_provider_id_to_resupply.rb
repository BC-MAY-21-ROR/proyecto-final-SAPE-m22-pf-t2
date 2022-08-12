class AddProviderIdToResupply < ActiveRecord::Migration[7.0]
  def change
    add_reference :resupplies, :provider, null: false, foreign_key: true
  end
end
