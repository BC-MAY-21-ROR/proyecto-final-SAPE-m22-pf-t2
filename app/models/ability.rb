# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, current_business = nil)
    return unless user.present?

    # Businesses
    can :edit, Business, owner: user

    # Users
    can :read, User
    can :edit, User, id: user.id
    can :update, User, id: user.id

    return unless current_business.present?

    # Business enrollments
    enrollment = BusinessEnrollment.enrollment_for(user, current_business)
    if enrollment.admin_role?
      can :create_and_enroll, User
      can :enroll_existing_user, User
      can :remove_employee, User
    end
  end
end
