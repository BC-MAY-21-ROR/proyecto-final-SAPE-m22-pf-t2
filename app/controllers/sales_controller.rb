class SalesController < ApplicationController
  include SalesHelper

  before_action :authenticate_user!
  before_action :init_sale_products
  before_action :set_sale, only: %i[show edit update destroy]

  def index
    @sales = Sale.all
  end

  def add_product_to_sale
    product_id = params[:product_id]
    quantity = params[:quantity]
    save_product_to_sale(product_id, quantity)

    redirect_to new_sale_path
  end

  def show; end

  def new
    @sale = Sale.new
    @products = Product.search_by_name_and_description(params[:query])
    @sale_products = sale_products
    @total_for_sale_products = calculate_total_for_sale_products(@sale_products)
    puts @total_for_sale_products
  end

  def edit; end

  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
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

  def init_sale_products
    session[:sale_products] ||= []
  end

  def sale_products
    session[:sale_products].map do |sale_product|
      product = Product.find(sale_product['product_id'])
      {
        product_id: product.id,
        product_code: product.code,
        product_name: product.name,
        product_price: product.price,
        quantity: sale_product['quantity']
      }
    end
  end

  def save_product_to_sale(product_id, quantity)
    remove_product_from_sale(product_id)
    session[:sale_products] << { product_id:, quantity: }
  end

  def remove_product_from_sale(product_id)
    session[:sale_products].reject! { |sale_product| sale_product['product_id'] == product_id }
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.fetch(:sale, {})
  end
end
