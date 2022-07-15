class Business < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :name, :business_type, :address, presence: true

  validates :name, length: { minimum: 5 }
  validates :business_type, length: { minimum: 3 }
  validates :address, length: { minimum: 5 }
end
