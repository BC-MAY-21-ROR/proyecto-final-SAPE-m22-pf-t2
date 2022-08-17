class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do
    ActiveStorage::Current.url_options = {
      protocol: request.protocol,
      host: request.host,
      port: request.port
    }
  end

  def index
    @clients = Client.all

    if current_business_id.present?
      @current_business = Business.find_by_id(current_business_id)
      return
    end

    if current_user.owned_business.present?
      self.current_business = current_user.owned_business
    else
      redirect_to new_business_path
    end
  end
end
