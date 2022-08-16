class AddDefaultValueToExpenseFields < ActiveRecord::Migration[7.0]
  def change
    change_column_default :expenses, :rent, 0
    change_column_default :expenses, :salaries, 0
    change_column_default :expenses, :general_charges, 0
    change_column_default :expenses, :service_bills, 0
    change_column_default :expenses, :commissions, 0
    change_column_default :expenses, :taxes, 0
  end
end
