module ExpensesHelper
  def format_month_date(expense)
    expense.month.strftime('%Y-%m')
  end
end
