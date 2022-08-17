class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.decimal :rent
      t.decimal :salaries
      t.decimal :general_charges
      t.decimal :service_bills
      t.decimal :commissions
      t.decimal :amortizations
      t.decimal :taxes
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
