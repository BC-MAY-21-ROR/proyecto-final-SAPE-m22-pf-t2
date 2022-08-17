class AddAmortizationsToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :amortizations, :decimal, default: 0.0
  end
end
