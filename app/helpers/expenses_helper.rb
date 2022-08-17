module ExpensesHelper
  def format_month_from_expense(expense)
    expense.month.strftime('%Y-%m')
  end
end
