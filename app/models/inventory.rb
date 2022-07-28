class Inventory < ApplicationRecord
  belongs_to :business
  has_many :products
end
