class Business < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :country
  has_many :users, through: :business_enrollments
  has_many :business_enrollments
  has_many :products
  has_many :clients
  has_many :providers
  has_many :sales
  has_many :resupplies
  has_one_attached :logo
  after_commit :add_default_logo, on: %i[create update]

  validates_uniqueness_of :owner_id, message: 'can not have more than one owner'

  validates :name, :business_type, :address, :description, presence: true

  validates :name, length: { minimum: 5 }
  validates :business_type, length: { minimum: 3 }
  validates :address, length: { minimum: 5 }

  def add_default_logo
    return if logo.attached?

    logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_logo.png')),
                filename: 'default_logo.png',
                content_type: 'image/png')
  end
end
