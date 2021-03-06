class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]

  has_one :business
  has_many :business_enrollments
  has_many :businesses, through: :business_enrollments
  has_one :owned_business, class_name: 'Business', foreign_key: 'owner_id'

  has_one_attached :avatar

  validates :name, :email, presence: true
  validates :name, length: { minimum: 3 }
  validates :password, length: { minimum: 5 }, allow_blank: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.create_from_provider_data(provider_data)
    create!(
      name: provider_data.info.name,
      email: provider_data.info.email,
      password: Devise.friendly_token[0, 20],
      provider: provider_data.provider,
      uid: provider_data.uid
    )
  end
end
