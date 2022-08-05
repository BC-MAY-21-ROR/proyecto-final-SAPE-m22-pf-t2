module ProductUtils
  def map_product_to_hash(product, quantity)
    product_total = product.calculate_total_price(quantity)
    {
      product_id: product.id,
      product_code: product.code,
      product_name: product.name,
      product_price: product.price,
      quantity: quantity,
      total: product_total
    }
  end
end
