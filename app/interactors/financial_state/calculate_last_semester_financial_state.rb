class FinancialState::CalculateLastSemesterFinancialState
  include ExpensesHelper
  include Interactor

  def call
    context.financial_states = {}
    last_semester_expenses = Expense.where(business: context.business).limit(6).order('month desc')
    last_semester_expenses.each do |expense|
      result = FinancialState::CalculateFinancialStateFromExpense.call(
        {
          business: context.business,
          expense: expense
        }
      ).financial_state
      context.financial_states[format_month_from_expense(expense)] = result[:net_profit]
    end
  end
end
