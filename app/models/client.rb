class Client < ApplicationRecord
  belongs_to :business
  has_many :sales
end
