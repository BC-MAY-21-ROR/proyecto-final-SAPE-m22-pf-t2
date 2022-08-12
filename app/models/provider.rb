class Provider < ApplicationRecord
  belongs_to :business
  has_many :resupplies
end
