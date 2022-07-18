class BusinessEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :business

  enum role: %i[employee admin]

  def self.enrollment_for(user, business)
    where(user_id: user.id, business_id: business.id).first
  end

  def self.enrollments_for_user(user)
    where(user_id: user.id, owner: false)
  end

  def self.enrollments_for_user_excluding(user, business_to_exclude)
    where(
      'user_id = ? AND business_id != ? AND owner = ?',
      user.id,
      business_to_exclude.id,
      false
    )
  end

  def self.enrollments_for_business_excluding(business, user_to_exclude)
    where(
      'business_id = ? AND user_id != ?',
      business.id,
      user_to_exclude.id
    )
  end

  def self.enroll_user_to_business(user, business, user_role)
    create!(
      user_id: user.id,
      business_id: business.id,
      owner: false,
      role: user_role
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

  def self.user_has_own_business?(user)
    owned_business_for(user) != nil
  end

  def self.owned_business_for(user)
    where(
      user_id: user.id,
      owner: true
    ).first&.business
  end

  def self.user_owns_business?(user, business)
    where(
      user_id: user.id,
      business_id: business.id,
      owner: true
    ).first != nil
  end

  def self.user_enrolled?(user, business)
    BusinessEnrollment.where(
      user_id: user.id,
      business_id: business.id
    ).first != nil
  end

  def has_admin_role?
    role == 'admin'
  end
end
