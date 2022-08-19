class FinancialStatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show financial_state_pdf]

  def show
    prepare_financial_state
  end

  def financial_state_pdf
    prepare_financial_state
    respond_to do |format|
      format.pdf do
        render pdf: 'financial_state_pdf',
               template: 'financial_states/partials/_state_pdf',
               encoding: 'utf8',
               formats: [:html]
      end
    end
  end

  private

  def prepare_financial_state
    return unless @expense.present?

    @financial_state = FinancialState::CalculateFinancialStateFromExpense.call(
      {
        business: current_business,
        expense: @expense
      }
    ).financial_state
  end

  def set_expense
    @selected_month = params[:month]
    @expense = if @selected_month.present?
                 Expense.get_expense_of_month(current_business, @selected_month)
               else
                 Expense.order(:month).where(business: current_business).last
               end
  end
end
