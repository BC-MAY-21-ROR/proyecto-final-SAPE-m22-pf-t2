class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def current_business_id
    session['business_id']
  end
end
