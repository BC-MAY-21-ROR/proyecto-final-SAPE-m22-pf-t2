class FinancialStateController < ApplicationController
  before_action :authenticate_user!

  def index
    $final_expense = Expense.find_by(business_id: current_business_id)
    calculate_operations
  end

  def calculate_expense
    @total_expense = $final_expense.rent + $final_expense.salaries + $final_expense.general_charges + $final_expense.service_bills + $final_expense.commissions + $final_expense.taxes
  end

  def calculate_operations
    calculate_expense
    calculate_sales
    calculate_resupply
    calculate_total
  end

  def calculate_sales
    @sales = Sale.all
    @total_sale = 0
    @sales.each do |sale|
      @total_sale += sale[:total]
    end
    @total_sale
  end

  def calculate_resupply
    @resupply = Resupply.all
    @total_resupply = 0
    @resupply.each do |resupply|
      @total_resupply += resupply[:quantity]
    end
    @total_resupply
  end

  def calculate_total
    @total = @total_expense + @total_resupply + @total_sale
  end

  def state_details_pdf
    respond_to do |format|
      format.pdf do
        render pdf: 'financial_state_details',
               template: 'financial_state/partials/state',
               encoding: 'utf8',
               formats: [:html]
      end
    end
  end
end
