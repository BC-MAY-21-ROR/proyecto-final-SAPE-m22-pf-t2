class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    redirect_to new_business_path if current_admin.business.nil?
  end

  def business_date; end

  def inventory; end

  def providers; end

  def sales_and_purcharses; end

  def statement_of_income; end

  def balance_sheet; end
end
