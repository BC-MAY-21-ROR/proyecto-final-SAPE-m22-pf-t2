class BusinessEnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create_and_enroll_employee
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

  def join_to_enrolled_business
    self.current_business_id = params[:business_id]
    redirect_to dashboard_path
  end

  def remove_employee_from_current_business
    user_to_remove = User.find_by_id(params[:user_id])
    BusinessEnrollment.remove_enrollment(user_to_remove, current_business)
    redirect_to employees_path, notice: 'Employee removed from business'
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
