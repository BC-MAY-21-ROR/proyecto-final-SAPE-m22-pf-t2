class Expenses::CreateOrUpdateExpense
  include Interactor

  def call
    context.expense = Expense.where(month: parse_month_year_date).first

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
    context.expense_params.merge({ business: context.business, month: parse_month_year_date })
  end

  def parse_month_year_date
    return if context.expense_params[:month].empty?

    month_year_date = context.expense_params[:month].split('-')
    year = month_year_date[0].to_i
    month = month_year_date[1].to_i
    Date.new(year, month)
  end
end
