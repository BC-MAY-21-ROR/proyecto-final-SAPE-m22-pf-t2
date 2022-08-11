class Sales::CalculateTotalForSaleProducts
  include Interactor

  def call
    sale_total = 0
    context.sale_products.each do |sale_product|
      sale_total += sale_product[:total]
    end
    context.sale_total = sale_total
  end
end
