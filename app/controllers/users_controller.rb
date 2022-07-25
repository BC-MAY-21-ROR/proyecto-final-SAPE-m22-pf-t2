class UsersController < ApplicationController
  authorize_resource

  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(update_user_params)
        bypass_sign_in @user, scope: :user
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def update_user_params
    new_user_params = user_params
    if new_user_params['password'].empty?
      new_user_params.except('password', 'password_confirmation')
    else
      new_user_params
    end
  end
end
