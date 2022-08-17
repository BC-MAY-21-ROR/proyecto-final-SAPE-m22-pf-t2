class Expenses::CreateOrUpdateExpense
  include DateUtils
  include Interactor

  def call
    context.expense = Expense.get_expense_of_month(month_year)

    if context.expense
      update_expense
    else
      create_expense
    end
  end

  def update_expense
    context.fail! unless context.expense.update(expense_params)
  end

  def create_expense
    context.expense = Expense.new(expense_params)
    context.fail! unless context.expense.save
  end

  def expense_params
    context.expense_params.merge(
      { business: context.business, month: DateUtils.parse_month_year_date(month_year) }
    )
  end

  def month_year
    context.expense_params[:month]
  end
end
