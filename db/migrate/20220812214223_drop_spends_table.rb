class DropSpendsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :spents
  end
end
