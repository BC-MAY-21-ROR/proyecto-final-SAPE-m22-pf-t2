class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def index
    @clients = Client.all
    if current_business_id.present?
      @current_business = Business.find_by_id(current_business_id)
      return
    end

    if current_user.owned_business.nil?
      redirect_to new_business_path
    else
      self.current_business = current_user.owned_business
    end
  end

  def financial_state_info
    
    @expense = Expense.order(:month).last
    @sales_total = Sale.total_of_month(@expense.month)
    @resupplies_total = Resupply.total_of_month(@expense.month)
    @gross_profit = @sales_total - @resupplies_total
    @ebitda = @gross_profit - @expense.general_charges - @expense.rent - @expense.salaries
    @result_of_explotation = @ebitda - 0 # (- @expense.amortizations [Falta por poner en el entity])
    @result_before_taxes = @result_of_explotation - @expense.commissions
    @net_profit = @result_before_taxes - @expense.taxes
  end

end
