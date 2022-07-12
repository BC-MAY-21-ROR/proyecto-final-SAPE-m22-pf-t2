class OmniauthController < Devise::OmniauthCallbacksController
  def github
    sign_in_from_provider 'github'
  end

  def google_oauth2
    sign_in_from_provider 'google_oauth2'
  end

  def sign_in_from_provider(provider)
    provider_data = request.env['omniauth.auth']
    @admin = Admin.where(email: provider_data.info.email).first

    if @admin && @admin.provider != provider
      flash[:error] = "This acount was registered with the provider #{@admin.provider}."
      redirect_to new_admin_registration_url
      return
    end

    @admin = Admin.create_from_provider_data(provider_data) if @admin.nil?
    set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    sign_in_and_redirect @admin
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_admin_registration_url
  end
end
