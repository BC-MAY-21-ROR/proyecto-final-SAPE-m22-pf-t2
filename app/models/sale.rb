class Sale < ApplicationRecord
  has_many :product_sales
  has_many :products, through: :product_sales
  belongs_to :client

  def self.total_prices_sales
    sum(:total)
  end

end
