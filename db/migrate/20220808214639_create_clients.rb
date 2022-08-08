class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.references :business, foreign_key: true
      t.string :name
      t.string :email, null: true
      t.string :phone, null: true

      t.timestamps
    end
  end
end
