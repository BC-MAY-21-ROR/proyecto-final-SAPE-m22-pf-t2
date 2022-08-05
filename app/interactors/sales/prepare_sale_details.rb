class Sales::PrepareSaleDetails
  include ProductUtils
  include Interactor

  def call
    context.sale_products = ProductSale.where({ sale_id: context.sale.id })
    context.sale_products = context.sale_products.map do |sale_product|
      product_hash = map_product_to_hash(sale_product.product, sale_product.quantity)
    end
    context.sale_total = context.sale.total
  end
end
