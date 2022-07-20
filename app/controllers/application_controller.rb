class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def current_business
    Business.find_by_id(current_business_id)
  end

  def current_business=(business)
    self.current_business_id = business.id
  end

  def current_business_id
    session[:business_id]
  end

  def current_business_id=(business_id)
    session[:business_id] = business_id
  end

  before_action :set_locale

  def set_locale
    I18n.locale = params[:lang] || local_form_header || I18n.default_locale
  end

  def local_form_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end
end
