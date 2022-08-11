class ProductResupplie < ApplicationRecord
    belongs_to :product
    belongs_to :resupply
end
