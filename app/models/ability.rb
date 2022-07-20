# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :edit, Business, owner: user

    can :read, User
    can :edit, User, id: user.id
  end
end
