module SalesHelper
  def init_sale_products
    session[:sale_products] ||= []
  end

  def reset_sale_products
    session[:sale_products] = []
  end

  def save_product_to_sale_in_session(product_id, quantity)
    remove_product_sale_from_session(product_id)
    session[:sale_products] << { product_id:, quantity: }
  end

  def remove_product_sale_from_session(product_id)
    session[:sale_products].reject! { |sale_product| sale_product['product_id'] == product_id }
  end

  def session_sale_products
    session[:sale_products].map { |sale_product| sale_product.symbolize_keys! }
  end

  def calculate_total_for_sale_products(sale_products)
    result = 0
    sale_products.each do |sale_product|
      result += sale_product[:total]
    end
    result
  end

  def calculate_total_for(sale_product)
    product_price = sale_product[:product_price]
    quantity = sale_product[:quantity]
    total = product_price.to_f * quantity.to_i
    sale_product.merge!(total:)
  end
end
