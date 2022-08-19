class Sale < ApplicationRecord
  has_many :product_sales
  has_many :products, through: :product_sales
  belongs_to :client
  belongs_to :business

  def self.sales_of_month(business, month)
    where(
      business: business,
      created_at: month.beginning_of_month..month.end_of_month
    )
  end

  def self.total_of_month(business, month)
    sales_of_month(business, month).sum(:total)
  end
end
