class OmniauthController < Devise::OmniauthCallbacksController
  def github
    @admin = Admin.create_from_provider_data(request.env['omniauth.auth'])
    if @admin.persisted?
      sign_in_and_redirect @admin
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Github. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end
end
