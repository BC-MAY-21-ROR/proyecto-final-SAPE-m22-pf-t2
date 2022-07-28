class Expense < ApplicationRecord
  belongs_to :business
  validates :rent, :salaries, :general_charges, :service_bills, :commissions, :taxes, presence: true
end
