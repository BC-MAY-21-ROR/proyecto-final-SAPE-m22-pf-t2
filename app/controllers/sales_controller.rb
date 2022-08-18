class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :init_sale_products
  before_action :load_sale_products_from_session, only: %i[new create]
  before_action :set_sale, only: %i[show edit update destroy sale_details_pdf]

  def index
    @sales = current_business.sales
    @sales_total = @sales.sum(:total)
  end

  def show
    prepare_sale_details
  end

  def sale_details_pdf
    prepare_sale_details
    respond_to do |format|
      format.pdf do
        render pdf: "sale_details_#{@sale.id}",
               template: 'sales/partials/_sale_products',
               encoding: 'utf8',
               orientation: 'landscape',
               formats: [:html]
      end
    end
  end

  def search_products
    @query = params[:query]
    @products = Sales::SearchProducts.call(params.merge({ business_id: current_business_id })).products
    respond_to do |format|
      format.html { render partial: 'sales/partials/products_found' }
    end
  end

  def new
    @clients = current_business.clients
    @sale = Sale.new
  end

  def add_product_to_sale
    result = Sales::AddProductToSaleOrganizer.call(params.merge({ session: session }))
    @sale_products = result.sale_products
    @sale_total = result.sale_total

    respond_to do |format|
      format.html { render partial: 'sales/partials/sale_products' }
    end
  end

  def edit; end

  def create
    result = Sales::CreateSaleOrganizer.call(
      { business: current_business, sale_params: sale_params, session: session })
    @sale = result.sale

    respond_to do |format|
      if result.success?
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

  def remove_product_from_sale
    result = Sales::RemoveProductFromSaleInSessionOrganizer.call(
      { product_id: params[:product_id], session: session }
    )
    @sale_products = result.sale_products
    @sale_total = result.sale_total

    respond_to do |format|
      format.html { render partial: 'sales/partials/sale_products' }
    end
  end

  private

  def init_sale_products
    session[:sale_products] ||= []
  end

  def prepare_sale_details
    sale_details = Sales::PrepareSaleDetails.call({ sale: @sale })
    @sale_products = sale_details.sale_products
    @sale_total = sale_details.sale_total
  end

  def load_sale_products_from_session
    @sale_products = Sales::LoadSaleProductsFromSession.call({ session: session }).sale_products
    @sale_total = Sales::CalculateTotalForSaleProducts.call(sale_products: @sale_products).sale_total
  end

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client_id)
  end
end
