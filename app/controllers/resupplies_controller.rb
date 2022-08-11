class ResuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resupply, only: [:edit]

  def index
    @resupplies = Resupply.all
    @Product = Product.all
  end

  def new 
    @resupply = Resupply.new
    $product_url = params[:product_id]
  end

  def create
    @resupply = Resupply.new(resupply_params)
      if @resupply.save
        update_product
        redirect_to products_url
      else
        render :new, status: :unprocessable_entity
      end
  end

  def show;end

  def edit;end

  def update_product
    @product = Product.find_by(id: $product_url)
    new_stock = @product.stock + @resupply.quantity
    @product.update(stock: new_stock)
  end

  private 

  def request_url
    @query = request.query_parameters
  end

  def resupply_params
    params.require(:resupply).permit(
      :product_id,
      :quantity,
      :comment
    )
  end

end
