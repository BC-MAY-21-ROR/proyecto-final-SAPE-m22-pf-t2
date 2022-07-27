class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: 'Inventory was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to inventory_url(@inventory), notice: 'Inventory was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def add_product
    @product = Product.create!(
      name: @employee.id,
      code: current_month,
      price:
    )
  end

  def remove_product; end

  def destroy
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'Inventory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(:incomes, :outcomes)
  end

  def product_params
    params.require(:user).permit(
      :code,
      :name,
      :price,
      :password_confirmation
    )
  end
end
