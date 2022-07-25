class Business < ApplicationRecord
  has_many :business_enrollments
  has_many :users, through: :business_enrollments
  has_many :products
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :country

  validates_uniqueness_of :owner_id, message: 'can not have more than one owner'

  validates :name, :business_type, :address, presence: true

  validates :name, length: { minimum: 5 }
  validates :business_type, length: { minimum: 3 }
  validates :address, length: { minimum: 5 }
end
