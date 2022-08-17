class FinancialStatesController < ApplicationController
  before_action :authenticate_user!

  def show
    @expense = Expense.order(:month).last
    prepare_financial_state
  end

  def financial_state_of_month
    @expense = Expense.get_expense_of_month(expense_params[:month])
    respond_to do |format|
      if @expense.present?
        prepare_financial_state
        format.html { render :show, status: :ok }
      else
        format.html { redirect_to financial_state_path, status: :unprocessable_entity }
      end
    end
  end

  private

  def prepare_financial_state
    @sales_total = Sale.total_of_month(@expense.month)
    @resupplies_total = Resupply.total_of_month(@expense.month)
    @gross_profit = @sales_total - @resupplies_total
    @ebitda = @gross_profit - @expense.general_charges - @expense.rent - @expense.salaries
    @result_of_explotation = @ebitda - 0 # (- @expense.amortizations [Falta por poner en el entity])
    @result_before_taxes = @result_of_explotation - @expense.commissions
    @net_profit = @result_before_taxes - @expense.taxes
  end

  def expense_params
    params.require(:expense).permit(:month)
  end
end
