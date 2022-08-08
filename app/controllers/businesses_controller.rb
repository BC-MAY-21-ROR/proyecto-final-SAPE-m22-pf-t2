class BusinessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business, only: %i[show update destroy]
  before_action :set_countries, only: %i[new edit create update]
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def index_employees
    @current_user_enrollment = BusinessEnrollment.enrollment_for(current_user, current_business)
    @enrollments = BusinessEnrollment.enrollments_for_business_excluding(current_business, current_user)
    respond_to do |format|
      format.html { render template: 'businesses/employees/index' }
    end
  end

  def show
    @user_owns_current_business = current_user_owns_current_business
    @user_has_own_business = current_user.owned_business.present?
    @enrollments = BusinessEnrollment.enrollments_for_user_excluding(current_user, current_business)
    @user_role = BusinessEnrollment.user_roll_for_business(current_user, current_business)
  end

  def new
    if current_user.owned_business.present?
      redirect_to business_path
    else
      @business = Business.new
      @enrollments = BusinessEnrollment.enrollments_for_user(current_user)
    end
  end

  def new_employee
    authorize! :create_and_enroll, current_user
    @user = User.new
    respond_to do |format|
      format.html { render template: 'businesses/employees/new' }
    end
  end

  def edit
    if current_business_id.nil?
      redirect_to new_business_path
    else
      set_business
    end
    authorize! :edit, @business
  end

  def create
    @business = Business.new(business_params.merge({ owner: current_user }))

    respond_to do |format|
      if @business.save
        self.current_business = @business
        BusinessEnrollment.enroll_user_as_admin(current_user, @business)
        format.html { redirect_to dashboard_path, notice: 'Your own business was successfully created.' }
      else
        @enrollments = BusinessEnrollment.enrollments_for_user(current_user)
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def switch_to_own_business
    if current_user.owned_business.present?
      self.current_business = current_user.owned_business
      redirect_to dashboard_path
    else
      redirect_to new_business_path
    end
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
      :country_id,
      :description,
      :logo
    )
  end
end
