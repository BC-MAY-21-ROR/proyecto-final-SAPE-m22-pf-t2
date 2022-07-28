class Product < ApplicationRecord
  belongs_to :business

  validates :name, :code, :price, :stock, :description, presence: true

  validates :name, length: { minimum: 4 }
  validates :code, length: { minimum: 2 }
  validates :description, length: { minimum: 5 }
end
