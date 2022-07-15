class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_owns_business, only: [:index]

  def index
    selected_business_id = session['business_id']

    return unless selected_business_id.nil?

    if @user_owns_business
      session['business_id'] = @user_owns_business.business.id
      redirect_to dashboard_path
    else
      redirect_to new_business_path
    end
  end

  private

  def set_user_owns_business
    @user_owns_business = BusinessEnrollment.where(
      user_id: current_user.id,
      owner: true
    ).first
  end
end
