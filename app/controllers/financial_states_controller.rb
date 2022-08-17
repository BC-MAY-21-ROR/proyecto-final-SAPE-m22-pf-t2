class FinancialStatesController < ApplicationController
  before_action :authenticate_user!

  def show
    @selected_month = params[:month]
    @expense = if @selected_month.present?
                 Expense.get_expense_of_month(current_business, @selected_month)
               else
                 Expense.order(:month).where(business: current_business).last
               end
    prepare_financial_state
  end

  private

  def prepare_financial_state
    return unless @expense.present?

    @sales_total = Sale.total_of_month(@expense.month)
    @resupplies_total = Resupply.total_of_month(@expense.month)
    @gross_profit = @sales_total - @resupplies_total
    @ebitda = @gross_profit - @expense.general_charges - @expense.rent - @expense.salaries
    @result_of_explotation = @ebitda - @expense.amortizations
    @result_before_taxes = @result_of_explotation - @expense.commissions
    @net_profit = @result_before_taxes - @expense.taxes
  end
end
