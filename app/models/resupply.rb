class Resupply < ApplicationRecord
  belongs_to :product
  belongs_to :provider

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :provider, presence: true

  def calculate_total
    product.price * quantity
  end
end
