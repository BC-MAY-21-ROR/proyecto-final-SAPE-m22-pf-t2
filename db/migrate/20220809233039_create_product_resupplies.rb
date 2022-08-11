class CreateProductResupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :product_resupplies do |t|

      t.timestamps
    end
  end
end
