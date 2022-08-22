class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @pagy, @products = pagy(current_business.products)
    @total_value = Product.calculate_total_value(current_business)
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params.merge({ business: current_business }))

    respond_to do |format|
      if @product.save
        flash = {
          title: 'New product was created',
          body: "Product for code:#{@product.code} and name:#{@product.name} was succesfully created."
        }
        format.html { redirect_to products_path, success: flash }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        flash = {
          title: "Product for code:#{@product.code} and name:#{@product.name} was updated"
        }
        format.html { redirect_to products_path, success: flash }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      flash = {
        title: "Product for code:#{@product.code} and name:#{@product.name} was destroyed"
      }
      format.html { redirect_to products_url, success: flash }
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :code,
      :name,
      :purchase_price,
      :sale_price,
      :stock,
      :description
    )
  end
end
