class BusinessEnrollment < ApplicationRecord
  belongs_to :user
  belongs_to :business

  enum role: %i[employee admin]
end
