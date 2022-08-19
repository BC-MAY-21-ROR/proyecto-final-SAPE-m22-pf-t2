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
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
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
