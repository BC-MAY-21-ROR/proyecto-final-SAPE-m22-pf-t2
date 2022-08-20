class ResuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resupply, only: %i[show edit]
  before_action :set_providers, only: %i[new create]

  def index
    @selected_month = params[:month]
    @pagy, @resupplies = if @selected_month.present?
                    pagy(Resupply.resupplies_of_month(current_business, DateUtils.parse_month_year_date(@selected_month)))
                  else
                    pagy(current_business.resupplies)
                  end
    @resupplies_total = @resupplies.sum(:total)
  end

  def show; end

  def monthly_resupplies_pdf
    @selected_month = params[:month]
    @resupplies = Resupply.resupplies_of_month(current_business, DateUtils.parse_month_year_date(@selected_month))
    @resupplies_total = @resupplies.sum(:total)
    respond_to do |format|
      format.pdf do
        render pdf: "monthly_resupplies_#{@selected_month}",
               template: 'resupplies/partials/_monthly_resupplies_pdf',
               encoding: 'utf8',
               orientation: 'landscape',
               formats: [:html]
      end
    end
  end

  def new
    @resupply = Resupply.new
    @product_id = params[:product_id]
    redirect_to products_path unless @product_id.present?
  end

  def create
    result = Resupplies::CreateResupply.call(
      {
        business: current_business,
        resupply_params: resupply_params
      }
    )
    @resupply = result.resupply
    
    if result.success?
      @product = Product.find_by(id: @product_id)
      flash = {
        title: "Resupply was created",
        body: "Ressuply for: #{@resupply.quantity} products was created"
      }
      redirect_to products_url , success: flash
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
