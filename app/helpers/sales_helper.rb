module SalesHelper
  def calculate_total_for_sale_products(sale_products)
    result = 0
    sale_products.each do |sale_product|
      enrich_sale_product_with_total(sale_product)
      result += sale_product[:total]
    end
    result
  end

  def enrich_sale_product_with_total(sale_product)
    product_price = sale_product[:product_price]
    quantity = sale_product[:quantity]
    total = product_price.to_f * quantity.to_i
    sale_product.merge!(total:)
  end
end
