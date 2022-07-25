class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def index
    if current_business_id.present?
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
