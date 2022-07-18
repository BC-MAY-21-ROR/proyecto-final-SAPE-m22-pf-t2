class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        enroll_user_to_business
        format.html { redirect_to users_path, notice: 'User was successfully enrolled.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def enroll_existing_user_to_current_business
    @user = User.find_by_email(params[:email])
    if @user.nil?
      redirect_to new_user_path, notice: 'Invalid email.'
    elsif BusinessEnrollment.user_enrolled?(@user, current_business)
      redirect_to new_user_path, notice: 'User already enrolled.'
    else
      enroll_user_to_business
      redirect_to users_path
    end
  end

  def enroll_user_to_business
    role = params[:role]
    BusinessEnrollment.enroll_user_to_business(@user, current_business, role)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
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
    params.require(:user).permit(:name, :email, :password)
  end
end
