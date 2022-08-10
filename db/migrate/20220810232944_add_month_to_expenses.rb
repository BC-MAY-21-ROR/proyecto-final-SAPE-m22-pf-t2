class AddMonthToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :month, :datetime
  end
end
