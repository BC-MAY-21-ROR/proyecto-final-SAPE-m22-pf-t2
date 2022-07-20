class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: %i[show edit update destroy]
  before_action :set_countries, only: %i[new edit create update]

  def index_employees
    @current_user_enrollment = BusinessEnrollment.enrollment_for(current_user, current_business)
    @enrollments = BusinessEnrollment.enrollments_for_business_excluding(current_business, current_user)
    respond_to do |format|
      format.html { render template: 'businesses/employees/index' }
    end
  end

  def show
    @user_owns_business = BusinessEnrollment.user_owns_business?(current_user, current_business)
    @user_has_own_business = BusinessEnrollment.user_has_own_business?(current_user)
    @enrollments = BusinessEnrollment.enrollments_for_user_excluding(current_user, current_business)
  end

  def new
    @business = Business.new
    @enrollments = BusinessEnrollment.enrollments_for_user(current_user)
  end

  def new_business_employee
    @user = User.new
    respond_to do |format|
      format.html { render template: 'businesses/employees/new' }
    end
  end

  def edit; end

  def create
    @business = Business.new(business_params)

    respond_to do |format|
      if @business.save
        BusinessEnrollment.enroll_own_business_for!(current_user, @business)
        self.current_business = @business
        format.html { redirect_to dashboard_path, notice: 'Your own business was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def switch_to_own_business
    self.current_business = BusinessEnrollment.owned_business_for(current_user)
    redirect_to dashboard_path
  end

  def join_to_enrolled_business
    self.current_business_id = params[:business_id]
    redirect_to dashboard_path
  end

  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to business_path, notice: 'Your own business was successfully updated.' }
      else
        format.html { render edit_business_path, status: :unprocessable_entity }
      end
    end
  end

  def remove_employee_from_current_business
    user_to_remove = User.find_by_id(params[:user_id])
    BusinessEnrollment.remove_enrollment(user_to_remove, current_business)
    redirect_to users_path, notice: 'Employee removed from business'
  end

  def destroy
    @business.destroy

    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
    end
  end

  private

  def set_business
    @business = Business.find(current_business_id)
  end

  def set_countries
    @countries = Country.all
  end

  def business_params
    params.require(:business).permit(
      :name,
      :business_type,
      :address,
      :country_id
    )
  end
end
