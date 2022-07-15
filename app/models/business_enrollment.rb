class BusinessEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :business

  enum role: %i[employee admin]

  def self.enroll_own_business_for!(current_user, business)
    create!(
      user_id: current_user.id,
      business_id: business.id,
      owner: true,
      role: :admin
    )
  end
end
