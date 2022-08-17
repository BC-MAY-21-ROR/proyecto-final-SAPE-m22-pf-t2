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

    @financial_state = FinancialState::CalculateFinancialStateFromExpense.call(
      { business: current_business, expense: @expense }
    ).financial_state
  end
end
