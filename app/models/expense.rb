class Expense < ApplicationRecord
  include DateUtils

  belongs_to :business

  validates :month, presence: true
  validates :rent, :salaries, :general_charges, :service_bills, :commissions, :taxes, :amortizations,
            numericality: { greater_than_or_equal_to: 0 }

  def self.get_expense_of_month(month_year)
    where(month: DateUtils.parse_month_year_date(month_year)).first
  end
end
