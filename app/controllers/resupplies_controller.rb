class ResuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resupply, only: %i[show edit]
  before_action :set_providers, only: %i[new create]

  def index
    @resupplies = Resupply.all
  end

  def show;end 

  
  def new
    @resupply = Resupply.new
    @product_id = params[:product_id]
    redirect_to products_path unless @product_id.present?
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

  def show; end

  def edit; end

  def update_product
    @product = Product.find(@resupply.product_id)
    new_stock = @product.stock + @resupply.quantity
    @product.update(stock: new_stock)
  end

  private

  def set_resupply
    @resupply = Resupply.find(params[:id])
  end

  def set_providers
    @providers = Provider.all
  end

  def resupply_params
    params.require(:resupply).permit(
      :product_id,
      :provider_id,
      :quantity,
      :comment
    )
  end
end
