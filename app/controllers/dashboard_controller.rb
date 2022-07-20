class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    unless current_business_id.nil?
      @current_business = Business.find_by_id(current_business_id)
      return
    end

    if BusinessEnrollment.user_has_own_business?(current_user)
      self.current_business = BusinessEnrollment.owned_business_for(current_user)
    else
      redirect_to new_business_path
    end
  end
end
