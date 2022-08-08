class Business < ApplicationRecord
  has_one :products
  has_many :business_enrollments
  has_many :users, through: :business_enrollments
  has_one_attached :logo
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :country
  after_commit :add_default_logo, on: %i[create update]

  validates_uniqueness_of :owner_id, message: 'can not have more than one owner'

  validates :name, :business_type, :address, :description, presence: true

  validates :name, length: { minimum: 5 }
  validates :business_type, length: { minimum: 3 }
  validates :address, length: { minimum: 5 }

  def add_default_logo
    unless logo.attached?
      logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_logo.png')),
                  filename: 'default_logo.png',
                  content_type: 'image/png')
    end
  end
end
