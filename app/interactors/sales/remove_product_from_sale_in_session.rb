class Sales::RemoveProductFromSaleInSession
  include Interactor

  def call
    context
      .session[:sale_products]
      .reject! { |sale_product| sale_product['product_id'] == context.product_id }
  end
end
