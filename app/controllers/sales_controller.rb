class SalesController < ApplicationController
  include SalesHelper

  before_action :authenticate_user!
  before_action :init_sale_products
  before_action :set_sale_products, only: %i[new create]
  before_action :set_sale, only: %i[show edit update destroy]

  def index
    @sales = Sale.all
  end

  def add_product_to_sale
    product_id = params[:product_id]
    quantity = params[:quantity]
    save_product_to_sale_in_session(product_id, quantity)

    redirect_to new_sale_path
  end

  def show; end

  def new
    @query = params[:query]
    @sale = Sale.new
    @products = @query.present? ? Product.search_by_name_and_description(@query) : nil
    @total_for_sale_products = calculate_total_for_sale_products(@sale_products)
  end

  def edit; end

  def create
    sale_amount = calculate_total_for_sale_products(@sale_products)
    @sale = Sale.new(sale_params.merge({ amount: sale_amount }))

    respond_to do |format|
      if @sale.save
        save_sale_products(@sale)
        update_stock_of_sale_products
        reset_sale_products
        format.html { redirect_to sale_url(@sale), notice: 'Sale was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sale_url(@sale), notice: 'Sale was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
    end
  end

  private

  def set_sale_products
    @sale_products = session_sale_products.map do |sale_product|
      product = Product.find(sale_product[:product_id])
      calculate_total_for(
        {
          product_id: product.id,
          product_code: product.code,
          product_name: product.name,
          product_price: product.price,
          quantity: sale_product[:quantity]
        }
      )
    end
  end

  def save_sale_products(sale)
    ProductSale.create!(
      session_sale_products.map { |sale_product| sale_product.merge({ sale_id: sale.id }) }
    )
  end

  def update_stock_of_sale_products
    @sale_products.each do |sale_product|
      product = Product.find_by_id(sale_product[:product_id])
      product.update({ stock: (product.stock - sale_product[:quantity].to_i) })
    end
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client)
  end
end
