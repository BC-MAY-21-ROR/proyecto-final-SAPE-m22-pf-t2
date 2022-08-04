class ChangeSalesAmountColumnToTotal < ActiveRecord::Migration[7.0]
  def change
    rename_column :sales, :amount, :total
  end
end
