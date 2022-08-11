class Resupply < ApplicationRecord
  has_many :products
  validates :quantity, presence: true, numericality: true
end
