class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.references :admin
      t.references :country

      t.string :name
      t.string :business_type
      t.string :address

      t.timestamps
    end
  end
end
