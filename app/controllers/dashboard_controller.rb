class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_own_business_enrollment, only: [:index]

  def index
    return unless current_business_id.nil?

    if @own_business_enrollment
      set_current_business_id(@own_business_enrollment.business.id)
      redirect_to dashboard_path
    else
      redirect_to new_business_path
    end
  end

  private

  def set_own_business_enrollment
    @own_business_enrollment = BusinessEnrollment.where(
      user_id: current_user.id,
      owner: true
    ).first
  end
end
