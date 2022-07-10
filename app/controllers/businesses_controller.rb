class BusinessesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_business, only: %i[show edit update destroy]
  before_action :set_countries, only: %i[new edit create update]

  def index
    @businesses = Business.all
  end

  def show; end

  def new
    @business = Business.new
  end

  def edit; end

  def create
    @business = Business.new(business_params)
    @business.admin = current_admin

    respond_to do |format|
      if @business.save
        format.html { redirect_to dashboard_path, notice: 'Business was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to business_url(@business), notice: 'Business was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
    @business = Business.find(params[:id])
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
