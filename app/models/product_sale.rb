class ProductSale < ApplicationRecord
  belongs_to :product
  belongs_to :sale
end
