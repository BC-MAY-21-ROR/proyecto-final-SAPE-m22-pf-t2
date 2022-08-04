module SalesHelper
  def init_sale_products
    session[:sale_products] ||= []
  end

  def reset_sale_products
    session[:sale_products] = []
  end

  def save_product_to_sale_in_session(product_id, quantity)
    remove_product_sale_from_session(product_id)
    session[:sale_products] << { product_id: product_id, quantity: quantity}
  end

  def remove_product_sale_from_session(product_id)
    session[:sale_products].reject! { |sale_product| sale_product['product_id'] == product_id }
  end

  def session_sale_products
    session[:sale_products].map(&:symbolize_keys!)
  end

  def calculate_total_for_sale_products(sale_products)
    result = 0
    sale_products.each do |sale_product|
      result += sale_product[:total]
    end
    result
  end

  def enrich_with_total_for(sale_product)
    product_price = sale_product[:product_price]
    quantity = sale_product[:quantity]
    total = product_price.to_f * quantity.to_i
    sale_product.merge!(total: total)
  end

  def map_to_products_hash(products)
    products.map { |product| map_to_product_with_quantity_hash(product) }
  end

  def map_to_product_with_quantity_hash(product, quantity)
    {
      product_id: product.id,
      product_code: product.code,
      product_name: product.name,
      product_price: product.price,
      quantity: quantity
    }
  end
end
