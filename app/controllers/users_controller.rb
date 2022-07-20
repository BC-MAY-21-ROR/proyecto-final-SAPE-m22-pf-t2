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
        format.html { redirect_to employees_path, notice: 'User was successfully enrolled.' }
      else
        format.html { render template: 'businesses/employees/new', status: :unprocessable_entity }
      end
    end
  end

  def enroll_existing_user_to_current_business
    @user = User.find_by_email(params[:email])
    if @user.nil?
      redirect_to new_employee_path, notice: 'Invalid email.'
    elsif BusinessEnrollment.user_enrolled?(@user, current_business)
      redirect_to new_employee_path, notice: 'User already enrolled.'
    else
      enroll_user_to_business
      redirect_to employees_path
    end
  end

  def enroll_user_to_business
    role = params[:role]
    BusinessEnrollment.enroll_user_to_business(@user, current_business, role)
  end

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
