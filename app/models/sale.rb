class Sale < ApplicationRecord
  has_many :product_sales
  has_many :products, through: :product_sales
end
