class Sale < ApplicationRecord
  has_many :product_sales
  has_many :products, through: :product_sales
  belongs_to :client

  def self.total_of_month(month)
    where(created_at: month.beginning_of_month..month.end_of_month)
      .sum(:total)
  end

  def self.total_prices_sales
    sum(:total)
  end
  
end
