class ResuppliesController < ApplicationController
  before_action :set_resupply, only: [:edit]

  def index
    @resupplies = Resupply.all
  end

  def new 
    @resupply = Resupply.new
  end

  def create
    @resupply = Resupply.new(resupply_params)
    if @resupply.save
      redirect_to resupply_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private 

  def set_resupply
    @resupply = Resupply.find(params[:id])
  end

  def resupply_params
    params.require(:resupply).permit(
      :quantity,
      :comment
    )
  end
end
