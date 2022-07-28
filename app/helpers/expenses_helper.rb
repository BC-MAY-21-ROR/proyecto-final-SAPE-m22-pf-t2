module ExpensesHelper
  def businesses_to_options(businesses)
    @businesses.map { |business| [business.name, business.id] }
  end
end
