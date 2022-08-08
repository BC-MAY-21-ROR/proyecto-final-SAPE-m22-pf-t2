class Sales::SaveProductToSaleInSession
  include Interactor

  def call
    product = find_product_in_session
    if product
      product['quantity'] = context.quantity
    else
      save_product_in_session
    end
  end

  def find_product_in_session
    context.session[:sale_products].find do |sale_product|
      sale_product['product_id'] == context.product_id
    end
  end

  def save_product_in_session
    context.session[:sale_products] << { product_id: context.product_id, quantity: context.quantity }
  end
end
