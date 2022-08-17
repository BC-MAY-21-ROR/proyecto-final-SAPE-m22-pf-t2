class FinancialState::CalculateFinancialStateFromExpense
  include Interactor

  def call
    context.financial_state = {}
    context.financial_state[:sales_total] = sales_total
    context.financial_state[:resupplies_total] = resupplies_total
    calculate_financial_state
  end

  def calculate_financial_state
    context.financial_state[:gross_profit] = calculate_gross_profit
    context.financial_state[:ebitda] = calculate_ebitda
    context.financial_state[:result_of_explotation] = calculate_result_of_explotation
    context.financial_state[:result_before_taxes] = calculate_result_before_taxes
    context.financial_state[:net_profit] = calculate_net_profit
  end

  def calculate_gross_profit
    sales_total = context.financial_state[:sales_total]
    resupplies_total = context.financial_state[:resupplies_total]
    sales_total - resupplies_total
  end

  def calculate_ebitda
    expense = context.expense
    gross_profit = context.financial_state[:gross_profit]
    gross_profit - expense.general_charges - expense.rent - expense.salaries - expense.service_bills
  end

  def calculate_result_of_explotation
    ebitda = context.financial_state[:ebitda]
    ebitda - context.expense.amortizations
  end

  def calculate_result_before_taxes
    result_of_explotation = context.financial_state[:result_of_explotation]
    result_of_explotation - context.expense.commissions
  end

  def calculate_net_profit
    result_before_taxes = context.financial_state[:result_before_taxes]
    result_before_taxes - context.expense.taxes
  end

  def sales_total
    Sale.total_of_month(context.business, context.expense.month)
  end

  def resupplies_total
    Resupply.total_of_month(context.business, context.expense.month)
  end
end
