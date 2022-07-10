class Business < ApplicationRecord
  belongs_to :admin
  belongs_to :country
end
