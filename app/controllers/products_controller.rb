class ProductsController < ApplicationController
  authorize_resource

  before_action :authenticate_user!
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_business, only: %i[new edit create update]

  def index
    @products = Product.all
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
        format.html { redirect_to product_url(@product), notice: 'Product was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
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

  def set_product
    @product = Product.find(params[:id])
  end

  def set_business
    @businesses = Business.all
  end

  def product_params
    params.require(:product).permit(
      :name,
      :code,
      :price,
      :stock,
      :description
    )
  end
end
