class ApplicationController < ActionController::Base
  before_action :set_locale, :there_are_countries?

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def current_user_owns_current_business
    return false if current_user.owned_business.nil?

    current_business_id == current_user.owned_business.id
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

  def current_ability
    @current_ability ||= Ability.new(current_user, current_business)
  end

  def set_locale
    I18n.locale = params[:lang] || local_form_header || I18n.default_locale
  end

  def there_are_countries?
    unless Country.all.count.eql?(total_countries)
      create_countries
    end
  end

  private
  def local_form_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end

  def create_countries
    countries = %w[Peru Mexico Argentina]
    countries.each do|country|
      Country.create(name: country)
    end
  end

  def total_countries
    3
  end
end
