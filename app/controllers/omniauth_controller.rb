class OmniauthController < Devise::OmniauthCallbacksController
  def github
    sign_in_from_provider 'github'
  end

  def google_oauth2
    sign_in_from_provider 'google_oauth2'
  end

  def sign_in_from_provider(provider)
    provider_data = request.env['omniauth.auth']
    @user = User.where(email: provider_data.info.email).first

    if @user && @user.provider != provider
      flash[:error] = "This acount was registered with the provider #{@user.provider}."
      redirect_to new_user_registration_url
      return
    end

    @user = User.create_from_provider_data(provider_data) if @user.nil?
    set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    sign_in_and_redirect @user
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end
