module ProductUtils
  def map_product_to_hash(product, quantity, sale_price = nil)
    product_total = product.calculate_total_price(quantity)
    {
      product_id: product.id,
      product_code: product.code,
      product_name: product.name,
      product_sale_price: sale_price.present? ? sale_price : product.sale_price,
      quantity: quantity,
      total: sale_price.present? ? sale_price * quantity : product_total
    }
  end
end
