class Resupply < ApplicationRecord
  belongs_to :product
  belongs_to :provider
  belongs_to :business

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :provider, presence: true

  def self.total_of_month(business, month)
    where(
      business: business,
      created_at: month.beginning_of_month..month.end_of_month
    ).inject(0) { |sum, resupply| sum + resupply.total }
  end
end
