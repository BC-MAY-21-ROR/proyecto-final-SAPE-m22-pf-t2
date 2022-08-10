class Expense < ApplicationRecord
  belongs_to :business
  validates :rent, :salaries, :general_charges, :service_bills, :commissions, :taxes,
            numericality: { greater_than_or_equal_to: 0 }
end
