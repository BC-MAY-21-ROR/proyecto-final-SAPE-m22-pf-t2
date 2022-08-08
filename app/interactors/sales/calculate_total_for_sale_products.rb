class Sales::CalculateTotalForSaleProducts
  include Interactor

  def call
    total = 0
    context.sale_products.each do |sale_product|
      total += sale_product[:total]
    end
    context.total = total
  end
end
