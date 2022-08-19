class ResuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resupply, only: %i[show edit]
  before_action :set_providers, only: %i[new create]

  def index
    @resupplies = current_business.resupplies
  end

  def show; end

  def new
    @resupply = Resupply.new
    @product_id = params[:product_id]
    redirect_to products_path unless @product_id.present?
  end

  def create
    result = Resupplies::CreateResupply.call({ business: current_business, resupply_params: resupply_params })
    @resupply = result.resupply

    if result.success?
      redirect_to products_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  private

  def set_resupply
    @resupply = Resupply.find(params[:id])
  end

  def set_providers
    @providers = current_business.providers
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
