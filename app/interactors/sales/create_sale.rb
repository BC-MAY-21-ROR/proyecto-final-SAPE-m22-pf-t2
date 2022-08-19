class Sales::CreateSale
  include Interactor

  def call
    context.sale = Sale.new(
      context.sale_params.merge({ business: context.business, total: context.sale_total })
    )

    if context.sale.save
      save_sale_products
      update_stock_of_sale_products
      reset_sale_products_in_session
    else
      context.fail!
    end
  end

  def save_sale_products
    ProductSale.create!(
      context.session[:sale_products].map do |sale_product|
        product = Product.find_by_id(sale_product[:product_id])
        sale_product.merge({ sale_id: context.sale.id, product_price: product.sale_price })
      end
    )
  end

  def update_stock_of_sale_products
    context.sale_products.each do |sale_product|
      product = Product.find_by_id(sale_product[:product_id])
      product.update({ stock: (product.stock - sale_product[:quantity].to_i) })
    end
  end

  def reset_sale_products_in_session
    context.session[:sale_products] = []
  end
end
