class ResuppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resupply, only: [:edit]

  def index
    @resupplies = Resupply.all
    @Product = Product.all
  end

  def new 
    @resupply = Resupply.new
  end

  def create
    @resupply = Resupply.new(resupply_params)
    respond_to do |format|
      if @resupply.save
      format.html { redirect_to resupply_url(@resupply), notice: "Usuario was successfully created." }
      else
        render :new, status: :unprocessable_entity
      end
    end
  
  end

  def edit;end
  
  private 

  def set_resupply
    @resupply = Resupply.find(params[:id])
  end

  def resupply_params
    params.require(:resupply).permit(
      :product_id,
      :quantity,
      :comment
    )
  end

end
