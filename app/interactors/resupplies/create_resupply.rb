class Resupplies::CreateResupply
  include Interactor

  def call
    create_resupply

    if context.resupply.save
      update_product_stock
    else
      context.fail!
    end
  end

  def create_resupply
    @product = Product.find(context.resupply_params[:product_id])
    context.resupply = Resupply.new(
      context.resupply_params.merge(
        {
          business: context.business,
          total: @product.purcharse_price * context.resupply_params[:quantity].to_i
        }
      )
    )
  end

  def update_product_stock
    new_stock = @product.stock + context.resupply.quantity
    @product.update(stock: new_stock)
  end
end
