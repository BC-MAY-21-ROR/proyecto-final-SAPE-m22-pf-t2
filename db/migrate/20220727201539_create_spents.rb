class CreateSpents < ActiveRecord::Migration[7.0]
  def change
    create_table :spents do |t|
      t.decimal :amount
      t.decimal :total

      t.timestamps
    end
  end
end
