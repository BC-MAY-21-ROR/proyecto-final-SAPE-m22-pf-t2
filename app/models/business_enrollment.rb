class BusinessEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :business

  enum role: %i[employee admin]

  def self.enrollment_for(user, business)
    where(user_id: user.id, business_id: business.id).first
  end

  def self.enrollments_for_user(user)
    where(user_id: user.id)
  end

  def self.enrollments_for_user_excluding(user, business_to_exclude)
    where('user_id = ? AND business_id != ?', user.id, business_to_exclude.id)
      .reject { |enrollment| enrollment.business.owner == user }
  end

  def self.enrollments_for_business_excluding(business, user_to_exclude)
    where('business_id = ? AND user_id != ?', business.id, user_to_exclude.id)
  end

  def self.enroll_user_to_business(user, business, user_role)
    create!(
      user_id: user.id,
      business_id: business.id,
      role: user_role
    )
  end

  def self.enroll_user_as_admin(user, business)
    enroll_user_to_business(user, business, :admin)
  end

  def self.user_roll_for_business(user, business)
    where(
      user_id: user.id,
      business_id: business.id
    ).first&.role
  end

  def self.user_enrolled?(user, business)
    where(
      user_id: user.id,
      business_id: business.id
    ).first != nil
  end

  def self.remove_enrollment(user, business)
    where(
      user_id: user.id,
      business_id: business.id
    ).delete_all
  end

  def admin_role?
    role == 'admin'
  end
end
