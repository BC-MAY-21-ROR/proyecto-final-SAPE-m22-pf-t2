class Sales::LoadSaleProductsFromSession
  include ProductUtils
  include Interactor

  def call
    context.sale_products = session_sale_products.map do |sale_product|
      product = Product.find(sale_product[:product_id])
      map_product_to_hash(product, sale_product[:quantity])
    end
  end

  def session_sale_products
    context.session[:sale_products].map(&:symbolize_keys!)
  end
end
