class Inventory < ApplicationRecord
    belongs_to: business
    has_many: product
end
