class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]
  load_and_authorize_resource

  def show; end

  def edit; end

  def update
    user_params = remove_password_from_params_if_empty
    respond_to do |format|
      if @user.update(user_params)
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def remove_password_from_params_if_empty
    new_user_params = user_params
    if new_user_params['password'].empty?
      new_user_params.except('password', 'password_confirmation')
    else
      new_user_params
    end
  end
end
