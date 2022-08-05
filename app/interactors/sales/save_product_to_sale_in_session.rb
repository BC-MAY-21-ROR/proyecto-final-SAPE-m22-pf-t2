class Sales::SaveProductToSaleInSession
  include Interactor

  def call
    remove_product_sale_from_session
    context.session[:sale_products] << { product_id: context.product_id, quantity: context.quantity }
  end

  def remove_product_sale_from_session
    context
      .session[:sale_products]
      .reject! { |sale_product| sale_product['product_id'] == context.product_id }
  end
end
