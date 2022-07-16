class BusinessEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :business

  enum role: %i[employee admin]

  def self.enroll_user_to_business(user, business, role)
    create!(
      user_id: user.id,
      business_id: business.id,
      owner: false,
      role: role
    )
  end

  def self.enroll_own_business_for!(current_user, business)
    create!(
      user_id: current_user.id,
      business_id: business.id,
      owner: true,
      role: :admin
    )
  end
end
