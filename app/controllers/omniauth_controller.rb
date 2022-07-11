class OmniauthController < Devise::OmniauthCallbacksController
  def github
    sign_in_from_provider 'Github'
  end

  def google_oauth2
    sign_in_from_provider 'Google'
  end

  def sign_in_from_provider(provider)
    @admin = Admin.create_from_provider_data(request.env['omniauth.auth'])
    if @admin.persisted?
      sign_in_and_redirect @admin
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      flash[:error] =
        "There was a problem signing you in through #{provider}. Please register or try signing in later."
      redirect_to new_admin_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_admin_registration_url
  end
end
