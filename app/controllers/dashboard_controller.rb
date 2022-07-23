class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_business_id.nil?
      @current_business = Business.find_by_id(current_business_id)
      return
    end

    if current_user.owned_business.nil?
      redirect_to new_business_path
    else
      self.current_business = current_user.owned_business
    end
  end
end
